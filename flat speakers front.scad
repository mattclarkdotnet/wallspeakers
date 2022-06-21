$fa = 1;
$fs = 0.01;

ff = 0.01; // fudge factor to remove zero-depth skeins

fp_thickness=9;
fp_width=170;
fp_height=500;
fp_roundover=4;
other_panel_thickness=9;

include <TEBM35C10.scad>
bmr_driver_x_offset = -40;
bmr_driver_y_offset = -180;

bass_driver_total_depth=37;
bass_driver_rebate_depth=5.3;
bass_driver_hole_diameter=128;
bass_driver_rebate_diameter=152.5;
bass_driver_screw_placement_diameter=140.1;
bass_driver_screwhole_diameter=4;
bass_driver_screw_offset=cos(45)*bass_driver_screw_placement_diameter/2;
bass_driver_x_offset=0;
bass_driver_y_offset=-60;

interior_depth=(bass_driver_total_depth-bass_driver_rebate_depth)-(fp_thickness-bass_driver_rebate_depth);


module bass_driver(x,y) {
    translate([x, y, fp_thickness/2]) {
        // bass driver hole
        cyl(d=bass_driver_hole_diameter,l=fp_thickness+ff);
        // bass driver rebate
        translate([0,0,bass_driver_rebate_depth/2])
            cyl(d=bass_driver_rebate_diameter,l=bass_driver_rebate_depth+ff);
        // bass driver screw holes
        screwhole(bass_driver_screw_offset,bass_driver_screw_offset,bass_driver_screwhole_diameter);
        screwhole(bass_driver_screw_offset,-bass_driver_screw_offset,bass_driver_screwhole_diameter);
        screwhole(-bass_driver_screw_offset,bass_driver_screw_offset,bass_driver_screwhole_diameter);
        screwhole(-bass_driver_screw_offset,-bass_driver_screw_offset,bass_driver_screwhole_diameter);
    }
}

module faceplate_body() {
    translate([fp_width/2,fp_height/2,fp_thickness/2])
        cuboid([fp_width,fp_height,fp_thickness], rounding=fp_roundover,
            edges=[TOP+FRONT,TOP+RIGHT,TOP+LEFT,TOP+BACK]);
}

color("Turquoise")
translate([0,0,other_panel_thickness+interior_depth]) {
    difference() {
        faceplate_body();
        bass_driver(fp_width/2, fp_height/2 + bass_driver_y_offset);
        bmr_driver(fp_width/2 + bmr_driver_x_offset, fp_height/2 + bmr_driver_y_offset);        
    }
}