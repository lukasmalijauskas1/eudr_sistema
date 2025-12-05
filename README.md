# EUDR_SISTEMA

EUDR atitikties tikrinimo ir atsekamumo informacinė sistema, skirta produktų ir tiekėjų duomenų valdymui, EUDR rizikos vertinimui ir DDS (Due Diligence Statement) dokumentų generavimui.

## Diegimo instrukcija (XAMPP aplinka)

1. Įdiegti XAMPP ir paleisti „Apache“ bei „MySQL“ servisus.
2. Projekto katalogą „EUDR_SISTEMA“ nukopijuoti į `C:\xampp\htdocs`. Šiame kataloge yra visi PHP ir CSS failai, biblioteka „tFPDF“ bei duomenų bazės struktūros failas `sql/eudr_sistema.sql`.
3. TCPDF biblioteką atsisiųsti atskirai iš oficialios „GitHub“ saugyklos: https://github.com/tecnickcom/TCPDF ir patalpinti ją į katalogą `EUDR_SISTEMA\`.
4. „phpMyAdmin“ aplinkoje sukurti naują duomenų bazę `eudr_sistema` ir į ją importuoti failą `sql/eudr_sistema.sql`, esantį projekto kataloge.
5. Jei reikia, faile `db.php` pakoreguoti prisijungimo prie duomenų bazės parametrus (host, user, password).
6. Naršyklėje atidaryti adresą `http://localhost/EUDR_SISTEMA/login.php` ir prisijungti administratoriaus paskyra. Sėkmingas prisijungimas patvirtina, kad žiniatinklio serveris, duomenų bazė ir aplikacija įdiegti teisingai ir sistema parengta naudojimui.
