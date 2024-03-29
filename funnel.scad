include <settings.scad>
use <strut.scad>

$fn=40;

module funnel(h=funnel_h, r1 = funnel_r, r2=0, hole_r=1.7, wall = 2.5) {

angle=90-atan((funnel_r)/funnel_h);
cone_displacement = funnel_wall/sin(angle);

translate([0,0,-h/2+strut_t/2+funnel_flange_t])
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
//translate([0,0,funnel_h-strut_t/2-1])
funnel_strut();

//!rotate(180,[1,0,0])
funnel();
    
//}
