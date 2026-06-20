# 🛡️ Bulletproof Visitenkarten-Etui (OpenSCAD)

Ein extrem robustes, einteiliges Visitenkarten-Etui für den harten Alltag in der Hosentasche (EDC). Entworfen in OpenSCAD, optimiert für den Support-freien FDM-Druck. 

Zusätzlich enthält dieses Projekt eine parametrische, zweifarbige Deckkarte (3D-gedruckte Visitenkarte), die als Schutz für die eigentlichen Papierkarten dient.

## 📐 Features
* **Einteiliges Design:** Kein Klemmen, keine brechenden Scharniere oder Schiebedeckel.
* **Support-Free:** Durch clevere 45-Grad-Winkel komplett ohne Stützstrukturen oder Bridging druckbar.
* **Hosentaschen-optimiert:** Abgerundete Kanten (3 mm Radius) verhindern unangenehmes Drücken.
* **Ergonomisch:** Die vordere Daumen-Mulde erlaubt das einfache Herausschieben einzelner Karten.
* **Parametrisch:** Vollständig anpassbar in OpenSCAD.

## 🛠️ Druck-Parameter (Cura Slicer / Anycubic i3 Mega)
* **Schichthöhe:** 0.16 mm 
* **Wandlinien:** 6 
* **Infill:** 20 % Gyroid 
* **Temperaturen:** 210 °C Hotend / 60 °C Ultrabase
* **Kühlung:** 100 % (Start ab Schicht 3)
* **Z-Hop:** Deaktiviert
* **Haftung:** Skirt

## 🎨 Anleitung: Die zweifarbige Deckkarte
Die Deckkarte ist exakt auf 0.16 mm Schichthöhe programmiert (4 Schichten Basis, 3 Schichten Text-Relief). Nutze auf dem i3 Mega **nicht** das Cura-Plugin "Pause at Height", sondern pausiere nach der 4. Schicht manuell über das Drucker-Display, um das Filament zu wechseln!
