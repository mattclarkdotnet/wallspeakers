ff = 0.01;

bmr_driver_rebate_diameter=52;
bmr_driver_rebate_depth=2;
bmr_driver_screw_placement_diameter=48;
bmr_driver_hole_diameter=46;
bmr_driver_screw_offset=cos(45)*bmr_driver_screw_placement_diameter/2;
bmr_driver_screwhole_diameter=2;
bmr_driver_screwpost_diameter=6;
bmr_driver_chamfer=4;

bass_driver_total_depth=37;
bass_driver_rebate_depth=5.3;
bass_driver_hole_diameter=128;
bass_driver_rebate_diameter=152.5;
bass_driver_screw_placement_diameter=140.1;
bass_driver_screwhole_diameter=4;
bass_driver_screw_offset=cos(45)*bass_driver_screw_placement_diameter/2;

include <BOSL2/std.scad>

module screwpost(x,y,t) {
    translate([x,y,0])
        cyl(d=bmr_driver_screwpost_diameter,l=t+ff);
}

module screwhole(x,y,r,t) {
    translate([x,y,0])
        cyl(d=r,l=t+ff);
}

module indent(x,y) {
    translate([x,y,0])
        cyl(d=bmr_driver_screwpost_diameter+ff,l=bmr_driver_rebate_depth+ff);
}

module bmr_driver_hole(t) {
    translate([0, 0, t/2]) {
        // BMR driver hole and posts
        difference() {
            cyl(d=bmr_driver_hole_diameter,l=t+ff);
            screwpost(bmr_driver_screw_offset, bmr_driver_screw_offset, t);
            screwpost(bmr_driver_screw_offset, -bmr_driver_screw_offset, t);
            screwpost(-bmr_driver_screw_offset, bmr_driver_screw_offset, t);
            screwpost(-bmr_driver_screw_offset, -bmr_driver_screw_offset, t);
        }
        screwhole(bmr_driver_screw_offset, bmr_driver_screw_offset, bmr_driver_screwhole_diameter, t);
        screwhole(bmr_driver_screw_offset, -bmr_driver_screw_offset, bmr_driver_screwhole_diameter, t);
        screwhole(-bmr_driver_screw_offset, bmr_driver_screw_offset, bmr_driver_screwhole_diameter, t);
        screwhole(-bmr_driver_screw_offset, -bmr_driver_screw_offset, bmr_driver_screwhole_diameter, t);
    }
}

module bmr_driver_rebate(t) {
    translate([0, 0, t - bmr_driver_rebate_depth/2]) {
        cyl(d=bmr_driver_rebate_diameter,l=bmr_driver_rebate_depth+ff);
        indent(bmr_driver_screw_offset,bmr_driver_screw_offset);
        indent(bmr_driver_screw_offset,-bmr_driver_screw_offset);
        indent(-bmr_driver_screw_offset,bmr_driver_screw_offset);
        indent(-bmr_driver_screw_offset,-bmr_driver_screw_offset);
    }
}

module LW150(x, y, panel_thickness) {
    // bass driver hole
    translate([x,y,panel_thickness-bass_driver_rebate_depth/2])
        cyl(d=bass_driver_rebate_diameter,l=bass_driver_rebate_depth+ff);
    translate([x, y, panel_thickness/2]) {
        cyl(d=bass_driver_hole_diameter,l=panel_thickness+ff);
    // bass driver rebate
    // bass driver screw holes
    screwhole(bass_driver_screw_offset, bass_driver_screw_offset, bass_driver_screwhole_diameter, panel_thickness);
    screwhole(bass_driver_screw_offset, -bass_driver_screw_offset, bass_driver_screwhole_diameter, panel_thickness);
    screwhole(-bass_driver_screw_offset, bass_driver_screw_offset, bass_driver_screwhole_diameter, panel_thickness);
    screwhole(-bass_driver_screw_offset, -bass_driver_screw_offset, bass_driver_screwhole_diameter, panel_thickness);
    }
}

module TEBM35C10(x, y, panel_thickness) {
    translate([x, y, 0]) {
        bmr_driver_hole(panel_thickness);
        bmr_driver_rebate(panel_thickness);
        // chamfer on back of BMR driver
        translate([0, 0, bmr_driver_chamfer/2])
            cyl(d=bmr_driver_hole_diameter,l=bmr_driver_chamfer+ff,chamfer1=-bmr_driver_chamfer);
    }
}
