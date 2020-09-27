include <tracer_bearing.scad>
include <strut.scad>
//use <rb-pulleys.scad>
//use <rods.scad>

$fn=40;
//tracer_bearing_assembly();
funnel_h = 70;
funnel_r = 50;
funnel_wall = 2.5;
funnel_flange = 3;
funnel_flange_t = 1;

angle=90-atan((funnel_r)/funnel_h);
cone_displacement = funnel_wall/sin(angle);

module funnel(h=funnel_h, r1 = funnel_r, r2=0, hole_r=1.7, wall = 2.5) {

translate([0,0,h/2])
difference() {
    union() {
        translate([0,0,h/2-funnel_flange_t/2])
    cylinder(r=r1+funnel_flange, h = funnel_flange_t, center=true);
    cylinder(r1=r2, r2=r1, h = h, center=true);
    }
    translate([0,0,cone_displacement])
    cylinder(r1=r2, r2=r1, h = h, center=true);
    cylinder(r=hole_r, h = h*3, center=true);
    }

}


module funnel_strut(h=70, r1 = 50, r2=0, hole_r=1.7, wall = 2.5) {
    difference() {

    //
    strut_spinner(ring_r = r1+5);
    translate([0,0,-h/2+strut_t/2+funnel_flange_t+smidge])
    cylinder(r1=r2, r2=r1, h = h, center=true); 
    }
}

//intersection() {
!translate([0,0,funnel_h-strut_t/2-1])
funnel_strut();

//!rotate(180,[1,0,0])
funnel();
    
//}
