// "Bulletproof" Visitenkarten-Etui v3
// Optimiert für Anycubic i3 Mega & 0.16mm Layer
$fn = 60; // Globale Auflösung

/* [Karten & Toleranzen] */
karten_b = 55;
karten_l = 85;
stapel_h = 6;
spielraum = 1.5;

/* [Gehäuse-Geometrie] */
wand      = 2.5;
boden     = 2.0;
r_aussen  = 3.0;

/* [Berechnungen] */
innen_b = karten_b + spielraum;
innen_l = karten_l + spielraum;
total_x = innen_b + 2*wand;
total_y = innen_l + wand;
total_z = boden + stapel_h + wand;

module abgerundeter_block(x, y, z, r) {
    hull() {
        for (i = [0, 1]) for (j = [0, 1])
            translate([i*(x-2*r)+r, j*(y-2*r)+r, 0]) 
                cylinder(h=z, r=r);
    }
}

module etui() {
    difference() {
        // Hauptkörper
        abgerundeter_block(total_x, total_y, total_z, r_aussen);
        
        // Innenraum für Karten
        translate([wand, -1, boden])
            cube([innen_b, innen_l + 1, stapel_h]);
            
        // Dachschräge (45 Grad) für supportfreien Druck
        translate([wand, -1, boden + stapel_h])
            hull() {
                cube([innen_b, innen_l + 1, 0.01]);
                translate([wand, 0, wand])
                    cube([innen_b - 2*wand, innen_l + 1, 0.01]);
            }
            
        // Daumenmulde
        translate([total_x/2, -0.5, boden + stapel_h/2])
            scale([1, 0.5, 1]) 
            cylinder(h=total_z + 5, r=18, center=true, $fn=100);
    }
}

// Zentrierung auf dem Druckbett
translate([-total_x/2, -total_y/2, 0])
    etui();
