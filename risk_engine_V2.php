<?php
// risk_engine_v2.php — Gate + Evidence + Art.10 penalties (3-band classification)
// DB-neutral (no country risk join) + model metadata for reproducibility.

const MODEL_VERSION = 'v2.0';

function model_metadata(array $W): array {
    return [
        'version' => MODEL_VERSION,
        'weights' => $W,
        'cutoffs' => ['ok' => 85, 'review' => 25], // >=85 ok; 25–84 review; <25 fail
        'notes'   => 'Gates + evidence score − Article 10 penalties'
    ];
}

function isValidLatLng($lat, $lng): bool {
    if ($lat === null || $lng === null) return false;
    if (!is_numeric($lat) || !is_numeric($lng)) return false;
    $lat = (float)$lat; $lng = (float)$lng;
    return $lat >= -90 && $lat <= 90 && $lng >= -180 && $lng <= 180;
}

function isValidGeoJSONPolygon(?string $geojson): bool {
    if (!$geojson) return false;
    $data = json_decode($geojson, true);
    if (!is_array($data)) return false;

    $type   = $data['type'] ?? null;
    $coords = $data['coordinates'] ?? null;
    if (!$type || !$coords) return false;

    $checkRing = function ($ring): bool {
        if (!is_array($ring) || count($ring) < 4) return false;
        $first = $ring[0]; $last = end($ring);
        return is_array($first) && is_array($last)
            && isset($first[0], $first[1], $last[0], $last[1])
            && $first[0] === $last[0] && $first[1] === $last[1];
    };

    if ($type === 'Polygon') {
        if (!is_array($coords) || count($coords) < 1) return false;
        return $checkRing($coords[0]);
    } elseif ($type === 'MultiPolygon') {
        if (!is_array($coords) || count($coords) < 1) return false;
        $poly = $coords[0] ?? null;
        if (!is_array($poly) || count($poly) < 1) return false;
        return $checkRing($poly[0]);
    }
    return false;
}

function calculateComplianceV2(PDO $pdo, int $productId): array {
    $stmt = $pdo->prepare("SELECT * FROM produktas WHERE ID = ?");
    $stmt->execute([$productId]);
    $p = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$p) throw new RuntimeException("Produktas nerastas.");

    $breakdown = [];

    // ===== HARD GATES =====
    $geoProvided = (int)($p['GeoProvided'] ?? 0) === 1;
    $areaHa      = isset($p['AreaHa']) && $p['AreaHa'] !== '' ? (float)$p['AreaHa'] : null;
    $lat         = $p['Latitude'] ?? null;
    $lng         = $p['Longitude'] ?? null;
    $polyJson    = $p['PlotGeoJSON'] ?? null;

    $geoOk = false;
    if ($areaHa !== null && $areaHa > 4) {
        $geoOk = $geoProvided && isValidGeoJSONPolygon($polyJson);
        $breakdown[] = ['rule'=>'GATE: Polygon for >4 ha','value'=>$geoOk?'OK':'FAIL','contrib'=>$geoOk?0:1];
    } else {
        $geoOk = $geoProvided && isValidLatLng($lat, $lng);
        $breakdown[] = ['rule'=>'GATE: Lat/Lng for ≤4 ha','value'=>$geoOk?'OK':'FAIL','contrib'=>$geoOk?0:1];
    }

    $legalOk      = (int)($p['LegalDocsProvided'] ?? 0) === 1;
    $deforOk      = (int)($p['DeforestationVerified'] ?? 0) === 1;
    $docsComplete = (int)($p['DocsComplete'] ?? 0) === 1;

    $breakdown[] = ['rule'=>'GATE: Legality documents','value'=>$legalOk?'OK':'FAIL','contrib'=>$legalOk?0:1];
    $breakdown[] = ['rule'=>'GATE: No deforestation after 2020-12-31','value'=>$deforOk?'OK':'FAIL','contrib'=>$deforOk?0:1];
    $breakdown[] = ['rule'=>'GATE: Complete documentation','value'=>$docsComplete?'OK':'FAIL','contrib'=>$docsComplete?0:1];

    if (!$geoOk || !$legalOk || !$deforOk || !$docsComplete) {
        $reasons = [];
        if (!$geoOk)        $reasons[] = ($areaHa !== null && $areaHa > 4) ? "Plotas >4 ha be Polygon/MultiPolygon GeoJSON" : "≤4 ha be platumos/ilgumos";
        if (!$legalOk)      $reasons[] = "Trūksta teisėtumo dokumentų";
        if (!$deforOk)      $reasons[] = "Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo";
        if (!$docsComplete) $reasons[] = "Dokumentų paketas nepilnas";

        return [
            'ab'=>0.0,'status'=>'Neatitinka','comment'=>implode('; ',$reasons),'risk'=>1.0,
            'breakdown'=>$breakdown,
            'model' => model_metadata(['docs'=>0.30,'geo'=>0.20,'decl'=>0.10,'cert'=>0.15,'trace'=>0.10,'ext'=>0.15])
        ];
    }

    // ===== EVIDENCE SCORE =====
    $W = ['docs'=>0.30,'geo'=>0.20,'decl'=>0.10,'cert'=>0.15,'trace'=>0.10,'ext'=>0.15];

    $docsScore  = 1.0;
    $geoScore   = $geoProvided ? 1.0 : 0.0;
    $declScore  = ((int)($p['SupplierDeclaration'] ?? 0) === 1) ? 1.0 : 0.0;
    $certScore  = max(0, min(1, ((int)($p['CertScore'] ?? 0))/10));
    $traceScore = max(0, min(1, ((int)($p['TraceabilityDepth'] ?? 0))/3));
    $extScore   = ((int)($p['ExternalVerification'] ?? 0) === 1) ? 1.0 : 0.0;

    $evidence = $W['docs']*$docsScore + $W['geo']*$geoScore + $W['decl']*$declScore + $W['cert']*$certScore + $W['trace']*$traceScore + $W['ext']*$extScore;
    $evidenceScore = round($evidence * 100, 2);

    $breakdown[] = ['rule'=>'Evidence: DocsComplete','value'=>$docsScore,'weight'=>$W['docs'],'contrib'=>$W['docs']*$docsScore];
    $breakdown[] = ['rule'=>'Evidence: Geolocation','value'=>$geoScore,'weight'=>$W['geo'],'contrib'=>$W['geo']*$geoScore];
    $breakdown[] = ['rule'=>'Evidence: SupplierDeclaration','value'=>$declScore,'weight'=>$W['decl'],'contrib'=>$W['decl']*$declScore];
    $breakdown[] = ['rule'=>'Evidence: Certifications','value'=>$certScore,'weight'=>$W['cert'],'contrib'=>$W['cert']*$certScore];
    $breakdown[] = ['rule'=>'Evidence: TraceabilityDepth','value'=>$traceScore,'weight'=>$W['trace'],'contrib'=>$W['trace']*$traceScore];
    $breakdown[] = ['rule'=>'Evidence: ExternalVerification','value'=>$extScore,'weight'=>$W['ext'],'contrib'=>$W['ext']*$extScore];

    // ===== ART. 10 PENALTIES =====
    $penalty = 0;
    if ((int)($p['IndigenousClaims'] ?? 0) === 1) $penalty += 15;
    if ((int)($p['SanctionsRisk'] ?? 0)    === 1) $penalty += 15;

    $LMH = function($v,$low,$med,$high){ return match (strtolower((string)$v)) {'low'=>$low,'med'=>$med,'high'=>$high, default=>$med}; };
    $penalty += $LMH($p['SupplyChainComplexity'] ?? 'med', 0,5,10);
    $penalty += $LMH($p['MixingRisk']             ?? 'med', 0,5,10);
    $penalty += $LMH($p['DocReliability']         ?? 'med', 10,5,0);
    $penalty += $LMH($p['LocalEnforcement']       ?? 'med', 10,5,0);

    $breakdown[] = ['rule'=>'Penalty: IndigenousClaims','value'=>(int)($p['IndigenousClaims'] ?? 0),'contrib'=>-15*((int)($p['IndigenousClaims'] ?? 0))];
    $breakdown[] = ['rule'=>'Penalty: SanctionsRisk','value'=>(int)($p['SanctionsRisk'] ?? 0),'contrib'=>-15*((int)($p['SanctionsRisk'] ?? 0))];
    $breakdown[] = ['rule'=>'Penalty: SupplyChainComplexity','value'=>($p['SupplyChainComplexity'] ?? 'med'),'contrib'=>-$LMH($p['SupplyChainComplexity'] ?? 'med',0,5,10)];
    $breakdown[] = ['rule'=>'Penalty: MixingRisk','value'=>($p['MixingRisk'] ?? 'med'),'contrib'=>-$LMH($p['MixingRisk'] ?? 'med',0,5,10)];
    $breakdown[] = ['rule'=>'Penalty: DocReliability','value'=>($p['DocReliability'] ?? 'med'),'contrib'=>-$LMH($p['DocReliability'] ?? 'med',10,5,0)];
    $breakdown[] = ['rule'=>'Penalty: LocalEnforcement','value'=>($p['LocalEnforcement'] ?? 'med'),'contrib'=>-$LMH($p['LocalEnforcement'] ?? 'med',10,5,0)];

    $ab = max(0, min(100, $evidenceScore - $penalty));

    if ($ab >= 85)         { $status='Atitinka';  $comment='Due-diligence pakankamas.'; }
    elseif ($ab >= 25)     { $status='Nežinoma';  $comment='Reikalinga papildoma informacija / rizikos mažinimas (11 str.).'; }
    else                   { $status='Neatitinka';$comment='Labai aukšta rizika; reikšmingas rizikos mažinimas būtinas.'; }

    $risk = max(0, min(1, 1 - ($ab/100)));

    // attach reproducible metadata
    $meta = model_metadata($W);

    return [
        'ab'        => round($ab,2),
        'status'    => $status,
        'comment'   => $comment,
        'risk'      => $risk,
        'breakdown' => $breakdown,
        'model'     => $meta,
    ];
}
