// 3D-gedruckte Visitenkarte / Deckkarte für das Etui
// 100% optimiert für Schichthöhe 0.16mm und manuellen Filamentwechsel

/* [Karten-Maße] */
karte_l = 85;
karte_b = 55;
r_ecken = 1.5;

/* [Dicken exakt nach Schichten] */
basis_h = 0.64;
relief_h = 0.48;

/* [Inhalt] */
vorname = "MAX";
nachname = "MUSTERMANN";
titel = "BEZEICHNUNG";

module basis_karte() {
    hull() {
        translate([r_ecken, r_ecken, 0]) cylinder(h=basis_h, r=r_ecken, $fn=60);
        translate([karte_l-r_ecken, r_ecken, 0]) cylinder(h=basis_h, r=r_ecken, $fn=60);
        translate([karte_l-r_ecken, karte_b-r_ecken, 0]) cylinder(h=basis_h, r=r_ecken, $fn=60);
        translate([r_ecken, karte_b-r_ecken, 0]) cylinder(h=basis_h, r=r_ecken, $fn=60);
    }
}

module text_relief() {
    translate([8, 34, basis_h])
        linear_extrude(height=relief_h)
            text(vorname, size=4.5, font="Roboto:style=Bold", spacing=1.1);
            
    translate([8, 22, basis_h])
        linear_extrude(height=relief_h)
            text(nachname, size=7, font="Roboto:style=Black", spacing=1.1);

    translate([8, 17, basis_h])
        cube([karte_l - 16, 0.8, relief_h]);

    translate([8, 11, basis_h])
        linear_extrude(height=relief_h)
            text(titel, size=3.2, font="Roboto:style=Regular", spacing=1.05);
}

translate([-karte_l/2, -karte_b/2, 0]) {
    basis_karte();
    text_relief();
}
