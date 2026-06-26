$fn = 60;

//
// Parameters
//

// Base dimension parameters (Inner card stack)
card_width = 56.5;
card_length = 86.5;
stack_height = 6.0;

// Shell structural parameters
wall_thickness = 2.5;
bottom_thickness = 2.0;
outer_radius = 3.0;
lip_height = 4.0;

// Fitment and tolerances
sliding_tolerance = 0.25;      // Clearance for a smooth sliding fit
snap_radius = 0.9;             // Radius of the snap-fit indents
snap_y_offset = 15.0;          // Y-axis distance from the back for snap-fit spheres
thumb_cutout_radius = 18.0;    // Radius for the thumb access cutout

// Calculated base part dimensions
base_x = card_width + 2 * wall_thickness;
base_y = card_length + wall_thickness;
base_z = bottom_thickness + stack_height + lip_height;

// Calculated inner shell dimensions (base + tolerance)
inner_x = base_x + 2 * sliding_tolerance;
inner_y = base_y + sliding_tolerance;
inner_z = base_z + sliding_tolerance;

// Calculated total outer shell dimensions
total_x = inner_x + 2 * wall_thickness;
total_y = inner_y + wall_thickness;
total_z = bottom_thickness + inner_z + lip_height;

//
// Helper modules
//

// Generates a rectangular solid with rounded corners in the XY plane
module rounded_cuboid(x_size, y_size, z_size, radius) {
    hull() {
        for (i = [0, 1]) {
            for (j = [0, 1]) {
                translate([
                    i * (x_size - 2 * radius) + radius, 
                    j * (y_size - 2 * radius) + radius, 
                    0
                ]) 
                cylinder(h = z_size, r = radius);
            }
        }
    }
}

//
// Main geometry
//

module outer_shell() {
    difference() {
        // 1. Main outer body
        rounded_cuboid(total_x, total_y, total_z, outer_radius);
        
        // 2. Inner void for the bottom part
        translate([wall_thickness, -1, bottom_thickness])
            cube([inner_x, inner_y + 1, inner_z]);
            
        // 3. Internal 45-degree chamfer for support-free roof printing
        translate([wall_thickness, -1, bottom_thickness + inner_z])
            hull() {
                cube([inner_x, inner_y + 1, 0.01]);
                translate([lip_height, 0, lip_height])
                    cube([inner_x - 2 * lip_height, inner_y + 1, 0.01]);
            }
            
        // 4. Elliptical thumb access cutout
        translate([total_x / 2, -0.5, bottom_thickness + inner_z / 2])
            scale([1, 0.5, 1]) 
            cylinder(h = total_z + 5, r = thumb_cutout_radius, center = true);
            
        // 5. Integrated snap-fit recesses (negatives for bottom part detents)
        for (x_pos = [wall_thickness, total_x - wall_thickness]) {
            translate([x_pos, inner_y - snap_y_offset, bottom_thickness + inner_z / 2]) 
                sphere(r = snap_radius, $fn = 30);
        }
    }
}

//
// Final assembly
//

// Center the part on the build plate for standard FDM printing
translate([-total_x / 2, -total_y / 2, 0])
    outer_shell();
