$fa = 1;
$fs = 0.01;

include <drivers.scad>
fp_thickness=9;
fp_width=180;
fp_height=500;
fp_roundover=4;

bmr_driver_x_offset = -fp_width/2+50;
bmr_driver_y_offset = -fp_height/2+70;
bass_driver_x_offset=0;
bass_driver_y_offset=-fp_height/2+190;

rebate=fp_thickness/2;
interior_depth=(bass_driver_total_depth-bass_driver_rebate_depth)-(fp_thickness-bass_driver_rebate_depth);
//interior_depth=32; // the driver only needs 28mm, but then the box volume is a bit smaller
echo(str("interior_depth(mm) = ", interior_depth));
echo(str("volume(l) = ", interior_depth*(fp_height-bp_thickness*2)*(fp_width-sp_thickness*2)/1000000));

bp_thickness = 9;
bp_width = fp_width;
bp_height = interior_depth + rebate*2;

sp_thickness = 9;
sp_width = fp_height - rebate*2;
sp_height = interior_depth + rebate*2;


module faceplate_body() {
    difference() {
        cuboid([fp_width,fp_height,fp_thickness], rounding=fp_roundover,
            edges=[TOP+FRONT,TOP+RIGHT,TOP+LEFT,TOP+BACK]);
        translate([0, 0, -(fp_thickness-rebate)])
            rect_tube(size=[fp_width+$fs,fp_height+$fs], h=rebate+$fs, wall=rebate+$fs);
    }
}

module rebated_panel(w,h,d,height,wall) {
    difference() {
        translate([0, 0, d/2])
            cuboid([w-$fs, h-$fs, d-$fs]);
        translate([0, 0, -$fs])
            rect_tube(size=[w+$fs, h+$fs], h=height+$fs, wall=wall+$fs);
    }

}

// Front panel
color("Turquoise")
difference() {
    faceplate_body();
    translate([0, bass_driver_y_offset, 0])
        LW150(fp_thickness);
    translate([bmr_driver_x_offset, bmr_driver_y_offset, 0])
        TEBM35C10(fp_thickness);        
}

// Bottom/top panel 1 (bottom)
color("Green")
    translate([0,-fp_height/2+bp_thickness,-bp_height/2])
        rotate([90,0,0])
            rebated_panel(bp_width, bp_height, bp_thickness, rebate, rebate);

// Bottom/top panel 2 (top)
color("Green")
    translate([0,fp_height/2-bp_thickness,-bp_height/2  ])
        rotate([90,0,180])
            rebated_panel(bp_width, bp_height, bp_thickness, rebate, rebate);

// Side panel 1 (right)
color("Yellow")
    translate([fp_width/2-sp_thickness, 0, -sp_height/2])
        rotate([90,0,90])
            rebated_panel(sp_width, sp_height, sp_thickness, rebate, rebate);

// Side panel 2 (left)
color("Yellow")
    translate([-fp_width/2+sp_thickness, 0, -sp_height/2])
        rotate([90,0,-90])
            rebated_panel(sp_width, sp_height, sp_thickness, rebate, rebate);

// Interior panel 1
ipw1=fp_width/2-sp_thickness/2;
color("Grey")
    translate([-ipw1/2+sp_thickness/2, -140, -sp_height/2])
        rotate([90,0,0])
            cuboid([ipw1, interior_depth, fp_thickness]);

// Interior panel 2
ipw2=(fp_height/2-140)-fp_thickness-fp_thickness/2;
color("Grey")
    translate([0, -fp_height/2+ipw2/2+bp_thickness, -sp_height/2])
        rotate([90,0,90])
            cuboid([ipw2, interior_depth, fp_thickness]);

// Interior brace
color("Grey")
    translate([0, fp_height/2-140, -sp_height/2])
        rotate([90,0,90])
            difference() {
                cuboid([interior_depth*3+5, interior_depth, fp_thickness]);
                xcopies(interior_depth, n=3)
                    cyl(d=interior_depth-5,l=fp_thickness+$fs);
            }



// Back panel (same as front panel without driver cutouts)
// color("Pink")
//     translate([0,0,-(sp_height-rebate)])
//         rotate([180,0,0])
//             rebated_panel(fp_width, fp_height, fp_thickness, rebate, rebate);