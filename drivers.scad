bmr_driver_rebate_diameter=52;
bmr_driver_rebate_depth=2.5; // flange depth is 2, add a bit to allow for gasket
bmr_driver_screw_placement_diameter=48;
bmr_driver_hole_diameter=46;
bmr_driver_screwhole_diameter=1.5; // for M2.5 screw (not bolt)
bmr_driver_screwpost_diameter=6;
bmr_driver_chamfer=4;

bass_driver_mounting_depth=32;
bass_driver_rebate_depth=6; // flange depth is 5.3, add a bit to allow for gasket
bass_driver_hole_diameter=128;
bass_driver_rebate_diameter=152.5;
bass_driver_screw_placement_diameter=140.1;
bass_driver_screwhole_diameter=4; // M4 bolt through 4.5mm hole in driver to allow for fitting slop

include <BOSL2/std.scad>

// a circular hole with scallops for the screwposts
module bmr_driver_hole(t) {
    difference() {
        cyl(d=bmr_driver_hole_diameter,l=t+$fs);
        arc_of(4, d=bmr_driver_screw_placement_diameter, sa=45, ea=315) {
            cyl(d=bmr_driver_screwpost_diameter,l=t+$fs);
        }   
    }
    arc_of(4, d=bmr_driver_screw_placement_diameter, sa=45, ea=315) {
        cyl(d=bmr_driver_screwhole_diameter,l=t+$fs);
    }
}

// A circular rebate with additional indents
module bmr_driver_rebate(t) {
    translate([0, 0, (t-bmr_driver_rebate_depth)/2]) {
        cyl(d=bmr_driver_rebate_diameter,l=bmr_driver_rebate_depth+$fs);
        arc_of(4, d=bmr_driver_screw_placement_diameter, sa=45, ea=315) {
            cyl(d=bmr_driver_screwpost_diameter+$fs,l=bmr_driver_rebate_depth+$fs);
        }
    }
}

module LW150(t) {
    // rebate
    translate([0, 0, (t-bass_driver_rebate_depth)/2])
        cyl(d=bass_driver_rebate_diameter,l=bass_driver_rebate_depth+$fs);
    // hole
    cyl(d=bass_driver_hole_diameter,l=t+$fs);
    // bass driver screw holes
    arc_of(4, d=bass_driver_screw_placement_diameter, sa=45, ea=315) {
        cyl(d=bass_driver_screwhole_diameter,l=t+$fs);
    }    
}

module TEBM35C10(t) {
    bmr_driver_rebate(t);
    bmr_driver_hole(t);
    // chamfer on back of BMR driver, with blocks removed where the screwposts go so they don't get chamfered
    translate([0, 0, -(t-bmr_driver_chamfer)/2])
        difference() {
            cyl(d=bmr_driver_hole_diameter,l=bmr_driver_chamfer+$fs,chamfer1=-bmr_driver_chamfer);
            arc_of(4, d=bmr_driver_screw_placement_diameter, sa=45, ea=315) {
                cuboid([bmr_driver_screwpost_diameter, bmr_driver_screwpost_diameter, t]); 
            }
        }
}

