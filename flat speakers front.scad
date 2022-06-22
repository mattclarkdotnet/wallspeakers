$fa = 1;
$fs = 0.01;

ff = 0.01; // fudge factor to remove zero-depth skeins

fp_thickness=9;
fp_width=170;
fp_height=500;
fp_roundover=4;
other_panel_thickness=9;

include <drivers.scad>
bmr_driver_x_offset = -40;
bmr_driver_y_offset = -180;

bass_driver_x_offset=0;
bass_driver_y_offset=-60;

interior_depth=(bass_driver_total_depth-bass_driver_rebate_depth)-(fp_thickness-bass_driver_rebate_depth);


module faceplate_body(x, y) {
    difference() {
        translate([x, y, fp_thickness/2])
            cuboid([fp_width,fp_height,fp_thickness], rounding=fp_roundover,
               edges=[TOP+FRONT,TOP+RIGHT,TOP+LEFT,TOP+BACK]);
        translate([x, y, 0])
            rect_tube(3, size=[fp_width,fp_height+ff], wall=3);
    }
}

color("Turquoise")
translate([0,0,other_panel_thickness+interior_depth]) {
    difference() {
        faceplate_body(fp_width/2, fp_height/2);
        LW150(fp_width/2, fp_height/2 + bass_driver_y_offset, fp_thickness);
        TEBM35C10(fp_width/2 + bmr_driver_x_offset, fp_height/2 + bmr_driver_y_offset, fp_thickness);        
    }
}