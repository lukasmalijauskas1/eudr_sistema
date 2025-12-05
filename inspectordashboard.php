<?php  
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'inspektorius') {
    header("Location: login.php");
    exit();
}

/* ---- Filters (shared) ---- */
$r_from = trim($_GET['from'] ?? '');
$r_to   = trim($_GET['to']   ?? '');

/* ---- Ataskaitos (reports) ---- */
$aq = "SELECT SukurimoData, PDFNuoroda FROM ataskaita WHERE 1=1";
$ap = [];
if ($r_from !== '') { $aq .= " AND SukurimoData >= ?"; $ap[] = $r_from . (strlen($r_from)===10 ? " 00:00:00" : ""); }
if ($r_to   !== '') { $aq .= " AND SukurimoData <= ?"; $ap[] = $r_to   . (strlen($r_to)===10   ? " 23:59:59" : ""); }
$aq .= " ORDER BY SukurimoData DESC";
$st = $pdo->prepare($aq); $st->execute($ap);
$reports = $st->fetchAll(PDO::FETCH_ASSOC);

/* ---- DDS (if table exists) ---- */
$dds = [];
if ($pdo->query("SHOW TABLES LIKE 'dd_statement'")->rowCount() > 0) {
    $dq = "SELECT Status, SukurimoData, PDFNuoroda FROM dd_statement WHERE 1=1";
    $dp = [];
    if ($r_from !== '') { $dq .= " AND SukurimoData >= ?"; $dp[] = $r_from . (strlen($r_from)===10 ? " 00:00:00" : ""); }
    if ($r_to   !== '') { $dq .= " AND SukurimoData <= ?"; $dp[] = $r_to   . (strlen($r_to)===10   ? " 23:59:59" : ""); }
    $dq .= " ORDER BY SukurimoData DESC";
    $st = $pdo->prepare($dq); $st->execute($dp);
    $dds = $st->fetchAll(PDO::FETCH_ASSOC);
}

/* helper: display with seconds if present */
function fmt_dt($s) { $s=(string)$s; return strlen($s)>10 ? date('Y-m-d H:i:s', strtotime($s)) : $s; }
?>
<!DOCTYPE html>
<html lang="lt">
<head>
    <meta charset="UTF-8">
    <title>Inspektoriaus skydelis</title>
    <link rel="stylesheet" href="style.css">
    <meta http-equiv="Cache-Control" content="no-store" />
    <style>
        .action-btn { background-color: #4CAF50; color: white; border: none; padding: 6px 10px; text-decoration: none; cursor: pointer; }
        .action-btn:hover { background-color: #45a049; }

        /* Keep panel inside viewport and stop horizontal overflow */
        html, body { overflow-x: hidden; }
        .panel {
          max-width: 980px;
          width: min(980px, calc(100vw - 32px)); /* 16px margin each side */
        }

        .section-card { background: rgba(255,255,255,0.92); border-radius: 10px; padding: 16px; margin: 16px 0; color:#111; }
        .section-card h3 { margin: 0 0 8px; color:#2c3e50; }

        /* Filter grid + overrides so inputs can shrink inside the grid */
        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 10px;
            align-items: end;
            margin: 8px 0 14px;
            max-width: 100%;
        }
        .filter-row input,
        .filter-row select {
            max-width: 100% !important;   /* override global 400px cap */
            width: 100%;
            box-sizing: border-box;
        }
        .filter-row .action-btn,
        .filter-row button {
            max-width: 100%;
            width: 100%;
        }
        @media (min-width: 560px) {
            .filter-row .action-btn,
            .filter-row button { width: auto; }
        }

        .table-wrap{
            max-height: 420px;
            overflow: auto;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: #fff;
            margin-top: 10px;
        }
        .inspector-table { width:100%; border-collapse:collapse; color:#111; background:#fff; }
        .inspector-table th, .inspector-table td { border:1px solid #eee; padding:8px 10px; white-space:nowrap; }
        .inspector-table thead th { position: sticky; top: 0; background:#f8f9fa; z-index: 2; }

        .meta { color:#555; font-size: 12px; margin-top: 6px; }
        .empty { margin: 8px 0 0; }
    </style>
</head>
<body class="forest-theme">
    <div class="center-container">
        <div class="panel">
            <h2>Inspektoriaus peržiūra</h2>

            <!-- Shared filters -->
            <form method="get" class="filter-row section-card">
                <div>
                    <label>Nuo</label>
                    <input type="date" name="from" value="<?= htmlspecialchars($r_from) ?>">
                </div>
                <div>
                    <label>Iki</label>
                    <input type="date" name="to" value="<?= htmlspecialchars($r_to) ?>">
                </div>
                <div>
                    <button type="submit" class="action-btn">🔎 Filtruoti</button>
                </div>
                <div class="meta">Filtras taikomas tiek ataskaitoms, tiek DDS.</div>
            </form>

            <!-- Ataskaitos -->
            <div class="section-card">
                <h3>Ataskaitos</h3>
                <?php if ($reports): ?>
                    <div class="table-wrap">
                        <table class="inspector-table">
                            <thead>
                                <tr>
                                    <th>Sukurta</th>
                                    <th>PDF</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($reports as $r): $file = basename($r['PDFNuoroda']); ?>
                                    <tr>
                                        <td><?= htmlspecialchars(fmt_dt($r['SukurimoData'])) ?></td>
                                        <td><a href="download_report.php?file=<?= urlencode($file) ?>" class="action-btn">📄 Peržiūrėti</a></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="meta">Rodoma: <?= count($reports) ?> įrašų</div>
                <?php else: ?>
                    <p class="empty">Nėra pateiktų ataskaitų pagal pasirinktą laikotarpį.</p>
                <?php endif; ?>
            </div>

            <!-- DDS -->
            <div class="section-card">
                <h3>Due Diligence Statements (DDS)</h3>
                <?php if ($dds): ?>
                    <div class="table-wrap">
                        <table class="inspector-table">
                            <thead>
                                <tr>
                                    <th>Statusas</th>
                                    <th>Sukurta</th>
                                    <th>PDF</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dds as $d): $file = basename($d['PDFNuoroda']); ?>
                                    <tr>
                                        <td><?= htmlspecialchars($d['Status']) ?></td>
                                        <td><?= htmlspecialchars(fmt_dt($d['SukurimoData'])) ?></td>
                                        <td>
                                            <?php if (!empty($file)): ?>
                                                <a href="download_report.php?file=<?= urlencode($file) ?>" class="action-btn">🧾 Atsisiųsti</a>
                                            <?php else: ?>-<?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="meta">Rodoma: <?= count($dds) ?> įrašų</div>
                <?php else: ?>
                    <p class="empty">DDS nerasta (arba neatitinka laikotarpio).</p>
                <?php endif; ?>
            </div>

            <div style="margin-top:12px;">
                <a href="logout.php">Atsijungti</a>
            </div>
        </div>
    </div>
</body>
</html>
