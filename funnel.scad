include <tracer_bearing.scad>
include <strut.scad>
use <rb-pulleys.scad>
use <rods.scad>

$fn=40;
//tracer_bearing_assembly();

module funnel(h=60, r1 = 40, r2=0, hole_r=1.7, wall = 1) {
angle=90-atan((r1-r2)/h);
cone_displacement = wall/sin(angle);

translate([0,0,h/2])
difference() {
    cylinder(r1=r2, r2=r1, h = h, center=true);
    translate([0,0,cone_displacement])
    cylinder(r1=r2, r2=r1, h = h, center=true);
    cylinder(r=hole_r, h = h*3, center=true);
    }
translate([0,0,h])
    rotate(180,[0,1,0])
    strut(ring_r = r1,do_bearing = 0);

}
rotate(180,[1,0,0])
funnel();

