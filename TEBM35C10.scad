bmr_driver_rebate_diameter=52;
bmr_driver_rebate_depth=2;
bmr_driver_screw_placement_diameter=48;
bmr_driver_hole_diameter=46;
bmr_driver_screw_offset=cos(45)*bmr_driver_screw_placement_diameter/2;
bmr_driver_screwhole_diameter=2;
bmr_driver_screwpost_diameter=6;
bmr_driver_chamfer=4;

include <BOSL2/std.scad>

module screwpost(x,y) {
    translate([x,y,0])
        cyl(d=bmr_driver_screwpost_diameter,l=fp_thickness+ff);
}

module screwhole(x,y,r) {
    translate([x,y,0])
        cyl(d=r,l=fp_thickness+ff);
}

module indent(x,y) {
    translate([x,y,0])
        cyl(d=bmr_driver_screwpost_diameter+ff,l=bmr_driver_rebate_depth+ff);
}

module bmr_driver_hole() {
    translate([0, 0, fp_thickness/2]) {
        // BMR driver hole and posts
        difference() {
            cyl(d=bmr_driver_hole_diameter,l=fp_thickness+ff);
            screwpost(bmr_driver_screw_offset,bmr_driver_screw_offset);
            screwpost(bmr_driver_screw_offset,-bmr_driver_screw_offset);
            screwpost(-bmr_driver_screw_offset,bmr_driver_screw_offset);
            screwpost(-bmr_driver_screw_offset,-bmr_driver_screw_offset);
        }
        screwhole(bmr_driver_screw_offset,bmr_driver_screw_offset, bmr_driver_screwhole_diameter);
        screwhole(bmr_driver_screw_offset,-bmr_driver_screw_offset, bmr_driver_screwhole_diameter);
        screwhole(-bmr_driver_screw_offset,bmr_driver_screw_offset, bmr_driver_screwhole_diameter);
        screwhole(-bmr_driver_screw_offset,-bmr_driver_screw_offset, bmr_driver_screwhole_diameter);
    }
}

module bmr_driver_rebate() {
    translate([0, 0, fp_thickness - bmr_driver_rebate_depth/2]) {
        cyl(d=bmr_driver_rebate_diameter,l=bmr_driver_rebate_depth+ff);
        indent(bmr_driver_screw_offset,bmr_driver_screw_offset);
        indent(bmr_driver_screw_offset,-bmr_driver_screw_offset);
        indent(-bmr_driver_screw_offset,bmr_driver_screw_offset);
        indent(-bmr_driver_screw_offset,-bmr_driver_screw_offset);
    }
}

module bmr_driver(x, y) {
    translate([x, y, 0]) {
        bmr_driver_hole();
        bmr_driver_rebate();
        // chamfer on back of BMR driver
        translate([0, 0, bmr_driver_chamfer/2])
            cyl(d=bmr_driver_hole_diameter,l=4+ff,chamfer1=-bmr_driver_chamfer);
    }
}
