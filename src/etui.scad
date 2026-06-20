// "Bulletproof" Visitenkarten-Etui v2 - Abgerundete Außenkanten
// 100% ohne Support, ohne Bridging.

/* [Karten & Toleranzen] */
karten_b = 55;
karten_l = 85;
stapel_h = 6;
spielraum = 1.5;

/* [Gehäuse] */
wand = 2.5;
boden = 2.0;
r_aussen = 3.0;

/* [Berechnete Innenmaße] */
innen_b = karten_b + spielraum;
innen_l = karten_l + spielraum;
total_x = innen_b + 2*wand;
total_y = innen_l + wand;
total_z = boden + stapel_h + wand;

module abgerundeter_block(x, y, z, r) {
    hull() {
        translate([r, r, 0]) cylinder(h=z, r=r, $fn=60);
        translate([x-r, r, 0]) cylinder(h=z, r=r, $fn=60);
        translate([x-r, y-r, 0]) cylinder(h=z, r=r, $fn=60);
        translate([r, y-r, 0]) cylinder(h=z, r=r, $fn=60);
    }
}

module etui() {
    difference() {
        abgerundeter_block(total_x, total_y, total_z, r_aussen);
        
        translate([wand, -1, boden])
            cube([innen_b, innen_l + 1, stapel_h]);
            
        translate([wand, -1, boden + stapel_h])
            hull() {
                translate([0, 0, 0])
                    cube([innen_b, innen_l + 1, 0.01]);
                translate([wand, 0, wand])
                    cube([innen_b - 2*wand, innen_l + 1, 0.01]);
                translate([wand, 0, wand + 5])
                    cube([innen_b - 2*wand, innen_l + 1, 0.01]);
            }
            
        translate([total_x/2, -0.5, boden + stapel_h/2])
            scale([1, 0.5, 1]) 
            cylinder(h=total_z + 5, r=18, center=true, $fn=100);
    }
}

translate([-total_x/2, -total_y/2, 0])
    etui();
