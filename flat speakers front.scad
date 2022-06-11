$fa = 1;
$fs = 0.1;

fp_thickness=9;
fp_width=170;
fp_height=500;
other_panel_thickness=9;

bass_driver_total_depth=37;
bass_driver_rebate_depth=5.3;
bass_driver_hole_diameter=128;
bass_driver_rebate_diameter=152.5;
bass_driver_screw_placement_diameter=140.1;
bass_driver_screwhole_diameter=4.5;
bass_driver_screw_offset=cos(45)*bass_driver_screw_placement_diameter/2;
bass_driver_y_offset=-60;

interior_depth=(bass_driver_total_depth-bass_driver_rebate_depth)-(fp_thickness-bass_driver_rebate_depth);

bmr_driver_screw_placement_diameter=48;
bmr_driver_hole_diameter=46;
bmr_driver_screw_offset=cos(45)*bmr_driver_screw_placement_diameter/2;
bmr_driver_screwhole_diameter=2;
bmr_driver_screwpost_diameter=6;
bmr_driver_x_offset=40;
bmr_driver_y_offset=60;

include <BOSL2/std.scad>

color("Turquoise")
translate([0,0,other_panel_thickness+interior_depth]) {
    difference() {
        // Main faceplate
        translate([fp_width/2,fp_height/2,fp_thickness/2])
            cuboid([fp_width,fp_height,fp_thickness], rounding=4,
                    edges=[TOP+FRONT,TOP+RIGHT,TOP+LEFT,TOP+BACK]);
        // bass driver
        translate([fp_width/2, fp_height/2 + bass_driver_y_offset,0])
            union() {
                // bass driver hole
                translate([0,0,fp_thickness/2])
                    cyl(d=bass_driver_hole_diameter,l=fp_thickness+0.1);
                // bass driver rebate
                translate([0,0,fp_thickness - bass_driver_rebate_depth/2 ])
                    cyl(d=bass_driver_rebate_diameter,l=bass_driver_rebate_depth+0.1);
                // bass driver screw holes
                translate([bass_driver_screw_offset,bass_driver_screw_offset,-0.1])
                    cyl(d=bass_driver_screwhole_diameter,l=fp_thickness+2);
                translate([bass_driver_screw_offset,-bass_driver_screw_offset,-0.1])
                    cyl(d=bass_driver_screwhole_diameter,l=fp_thickness+0.2);
                translate([-bass_driver_screw_offset,bass_driver_screw_offset,-0.1])
                    cyl(d=bass_driver_screwhole_diameter,l=fp_thickness+0.2);
                translate([-bass_driver_screw_offset,-bass_driver_screw_offset,-0.1])
                    cyl(d=bass_driver_screwhole_diameter,l=fp_thickness+0.2);
            
        }
        translate([bmr_driver_x_offset, bmr_driver_y_offset,0])
            union() {
                // BMR driver and screwposts
                difference() {
                    translate([0,0,fp_thickness/2])
                        cyl(d=bmr_driver_hole_diameter,l=fp_thickness+0.2);
                    translate([bmr_driver_screw_offset,bmr_driver_screw_offset,-0.1])
                        cylinder(d=bmr_driver_screwpost_diameter,h=fp_thickness+0.2);
                    translate([bmr_driver_screw_offset,-bmr_driver_screw_offset,-0.1])
                        cylinder(d=bmr_driver_screwpost_diameter,h=fp_thickness+0.2);
                    translate([-bmr_driver_screw_offset,bmr_driver_screw_offset,-0.1])
                        cylinder(d=bmr_driver_screwpost_diameter,h=fp_thickness+0.2);
                    translate([-bmr_driver_screw_offset,-bmr_driver_screw_offset,-0.1])
                        cylinder(d=bmr_driver_screwpost_diameter,h=fp_thickness+0.2);
                }
                // BMR driver screw holes
                translate([bmr_driver_screw_offset,bmr_driver_screw_offset,-0.1])
                    cylinder(d=bmr_driver_screwhole_diameter,h=fp_thickness+0.2);
                translate([bmr_driver_screw_offset,-bmr_driver_screw_offset,-0.1])
                    cylinder(d=bmr_driver_screwhole_diameter,h=fp_thickness+0.2);
                translate([-bmr_driver_screw_offset,bmr_driver_screw_offset,-0.1])
                    cylinder(d=bmr_driver_screwhole_diameter,h=fp_thickness+0.2);
                translate([-bmr_driver_screw_offset,-bmr_driver_screw_offset,-0.1])
                    cylinder(d=bmr_driver_screwhole_diameter,h=fp_thickness+0.2);
                
                // BMR driver rebate
                translate([0,0,fp_thickness-2.01]) {
                    cylinder(d=51.7,h=2.02);
                    // BMR driver rebate indents for screws
                    translate([bmr_driver_screw_offset,bmr_driver_screw_offset,0])
                        cylinder(d=8,h=2.02);
                    translate([bmr_driver_screw_offset,-bmr_driver_screw_offset,0])
                        cylinder(d=8,h=2.02);
                    translate([-bmr_driver_screw_offset,bmr_driver_screw_offset,0])
                        cylinder(d=8,h=2.02);
                    translate([-bmr_driver_screw_offset,-bmr_driver_screw_offset,0])
                        cylinder(d=8,h=2.02);
                }

         } 
    }
}

translate([0,0,interior_depth/2+other_panel_thickness]) {
    // bottom panel
    translate([fp_width/2,other_panel_thickness/2,0])
        cuboid([fp_width,other_panel_thickness,interior_depth]);

    // top panel
    translate([fp_width/2,fp_height-other_panel_thickness/2,0])
        cuboid([fp_width,other_panel_thickness,interior_depth]);

    // left panel
    color("Green")
    translate([other_panel_thickness/2,fp_height/2,0])
        cuboid([other_panel_thickness,fp_height-other_panel_thickness*2,interior_depth]);

    // right panel
    color("Green")
    translate([fp_width-other_panel_thickness/2,fp_height/2,0])
        cuboid([other_panel_thickness,fp_height-other_panel_thickness*2,interior_depth]);


    // bmr sub-enclosure
    translate([40,90,0])
        cuboid([40*2 - other_panel_thickness*2,other_panel_thickness,interior_depth]);

    translate([40*2 - other_panel_thickness-3,45,0])
        cuboid([other_panel_thickness,90-other_panel_thickness,interior_depth]);
}

// back panel
// color("Plum")
// translate([fp_width/2,fp_height/2,other_panel_thickness/2])
//    cuboid([fp_width,fp_height,other_panel_thickness]);
    