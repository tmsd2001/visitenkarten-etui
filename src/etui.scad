//
// Parameters
//

// Card dimensions
card_width          = 55;
card_length         = 85;
card_stack_height   = 6;

// Manufacturing tolerances
clearance           = 1.5;

// Case geometry
wall_thickness      = 2.5;
bottom_thickness    = 2.0;
outer_corner_radius = 3.0;

// Retention lip
retention_lip_height = 4.0;

// Thumb cutout
thumb_cutout_radius = 18;

// Rendering
$fn = 60;


//
// Derived dimensions
//
inner_width  = card_width  + clearance;
inner_length = card_length + clearance;

outer_width  = inner_width  + 2 * wall_thickness;
outer_length = inner_length + wall_thickness;
outer_height = bottom_thickness
             + card_stack_height
             + retention_lip_height;


//
// Rounded block
//
module rounded_block(
    width,
    length,
    height,
    corner_radius
) {

    hull() {

        for (x = [0, 1])
        for (y = [0, 1]) {

            translate([
                x * (width  - 2 * corner_radius) + corner_radius,
                y * (length - 2 * corner_radius) + corner_radius,
                0
            ])

            cylinder(
                h = height,
                r = corner_radius
            );
        }
    }
}


//
// Main card holder
//
module card_holder() {

    difference() {

        //
        // Outer body
        //
        rounded_block(
            outer_width,
            outer_length,
            outer_height,
            outer_corner_radius
        );

        //
        // Card compartment
        //
        translate([
            wall_thickness,
            -1,
            bottom_thickness
        ])

        cube([
            inner_width,
            inner_length + 1,
            card_stack_height
        ]);

        //
        // 45° support-free roof transition
        //
        translate([
            wall_thickness,
            -1,
            bottom_thickness + card_stack_height
        ])

        hull() {

            cube([
                inner_width,
                inner_length + 1,
                0.01
            ]);

            translate([
                retention_lip_height,
                0,
                retention_lip_height
            ])

            cube([
                inner_width - 2 * retention_lip_height,
                inner_length + 1,
                0.01
            ]);
        }

        //
        // Thumb access cutout
        //
        translate([
            outer_width / 2,
            -0.5,
            bottom_thickness + card_stack_height / 2
        ])

        scale([1, 0.5, 1])

        cylinder(
            h      = outer_height + 5,
            r      = thumb_cutout_radius,
            center = true,
            $fn    = 100
        );
    }
}


//
// Final assembly
//
translate([
    -outer_width / 2,
    -outer_length / 2,
    0
]) {

    card_holder();
}