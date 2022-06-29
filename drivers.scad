bmr_driver_rebate_diameter=52;
bmr_driver_rebate_depth=2;
bmr_driver_screw_placement_diameter=48;
bmr_driver_hole_diameter=46;
bmr_driver_screw_offset=cos(45)*bmr_driver_screw_placement_diameter/2;
bmr_driver_screwhole_diameter=2.5; // actual size of hole in driver
bmr_driver_screwpost_diameter=6;
bmr_driver_chamfer=4;

bass_driver_mounting_depth=37.8;
bass_driver_rebate_depth=5.3;
bass_driver_hole_diameter=128;
bass_driver_rebate_diameter=152.5;
bass_driver_screw_placement_diameter=140.1;
bass_driver_screwhole_diameter=4.5; // actual size of hole in driver
bass_driver_screw_offset=cos(45)*bass_driver_screw_placement_diameter/2;

include <BOSL2/std.scad>

module screwpost(x,y,t) {
    translate([x,y,0])
        cyl(d=bmr_driver_screwpost_diameter,l=t+$fs);
}

module screwhole(x,y,r,t) {
    translate([x,y,0])
        cyl(d=r,l=t+$fs);
}

module indent(x,y) {
    translate([x,y,0])
        cyl(d=bmr_driver_screwpost_diameter+$fs,l=bmr_driver_rebate_depth+$fs);
}

module bmr_driver_hole(t) {
    difference() {
        cyl(d=bmr_driver_hole_diameter,l=t+$fs);
        screwpost(bmr_driver_screw_offset, bmr_driver_screw_offset, t);
        screwpost(bmr_driver_screw_offset, -bmr_driver_screw_offset, t);
        screwpost(-bmr_driver_screw_offset, bmr_driver_screw_offset, t);
        screwpost(-bmr_driver_screw_offset, -bmr_driver_screw_offset, t);
    }
    screwhole(bmr_driver_screw_offset, bmr_driver_screw_offset, bmr_driver_screwhole_diameter - 0.5, t);
    screwhole(bmr_driver_screw_offset, -bmr_driver_screw_offset, bmr_driver_screwhole_diameter - 0.5, t);
    screwhole(-bmr_driver_screw_offset, bmr_driver_screw_offset, bmr_driver_screwhole_diameter - 0.5, t);
    screwhole(-bmr_driver_screw_offset, -bmr_driver_screw_offset, bmr_driver_screwhole_diameter - 0.5, t);
}

module bmr_driver_rebate(t) {
    translate([0, 0, (t-bmr_driver_rebate_depth)    /2]) {
        cyl(d=bmr_driver_rebate_diameter,l=bmr_driver_rebate_depth+$fs);
        indent(bmr_driver_screw_offset,bmr_driver_screw_offset);
        indent(bmr_driver_screw_offset,-bmr_driver_screw_offset);
        indent(-bmr_driver_screw_offset,bmr_driver_screw_offset);
        indent(-bmr_driver_screw_offset,-bmr_driver_screw_offset);
    }
}

module LW150(t) {
    // bass driver rebate
    translate([0, 0, (t-bass_driver_rebate_depth)/2])
        cyl(d=bass_driver_rebate_diameter,l=bass_driver_rebate_depth+$fs);
    // bass_driver_hole
    cyl(d=bass_driver_hole_diameter,l=t+$fs);
    // bass driver screw holes
    screwhole(bass_driver_screw_offset, bass_driver_screw_offset, bass_driver_screwhole_diameter - 0.5, t);
    screwhole(bass_driver_screw_offset, -bass_driver_screw_offset, bass_driver_screwhole_diameter - 0.5, t);
    screwhole(-bass_driver_screw_offset, bass_driver_screw_offset, bass_driver_screwhole_diameter - 0.5, t);
    screwhole(-bass_driver_screw_offset, -bass_driver_screw_offset, bass_driver_screwhole_diameter - 0.5, t);
    
}

module TEBM35C10(panel_thickness) {
    bmr_driver_rebate(panel_thickness);
    bmr_driver_hole(panel_thickness);
    // chamfer on back of BMR driver
    translate([0, 0, -(panel_thickness-bmr_driver_chamfer)/2])
        cyl(d=bmr_driver_hole_diameter,l=bmr_driver_chamfer+$fs,chamfer1=-bmr_driver_chamfer);
}

