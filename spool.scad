include <settings.scad>;
flange_ratio=.7;
module spool(
    spool_d = spool_d,
    spool_h = spool_h,
    spool_hole = spool_hole,
    spool_slope = spool_slope
    ) {



    difference() {
    union() {

        translate([0,0,spool_h/2])
        cylinder(r=spool_d/2, h=spool_h, center=true);


        translate([0,0,spool_h/4])
        cylinder(r1=spool_d*flange_ratio, r2=spool_d*spool_slope, h=spool_h/2, center=true);

        translate([0,0,spool_h/2+spool_h/4])
        rotate(180,[0,1,0])
        cylinder(r1=spool_d*flange_ratio, r2=spool_d*spool_slope, h=spool_h/2, center=true);
    }

    translate([0,0,spool_h/2])
    cylinder(r=spool_hole/2, h=spool_h*2, center=true);
    }

}


module spool_shaft(
    spool_d = spool_d,
    spool_h = spool_h,
    spool_hole = spool_hole,
    spool_slope = spool_slope,
    tol = spool_shaft_tol
    ) {

    translate([0,0,spool_h/2-smidge])
    cylinder(r=spool_hole/2-tol/2, h=spool_h, center=true);
}

//spool();
//spool_shaft();