include <tracer_bearing.scad>
use <rb-pulleys.scad>
use <rods.scad>

$fn=100;
//tracer_bearing_assembly();

module funnel(h=60, r1 = 40, r2=2, hole_r=1, wall = 1) {
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
    strut(ring_r = r1);

}

//projection(cut=true)
//rotate(90,[1,0,0])
//translate([0,0,60+2])
//rotate(180, [0,1,0])
//    funnel();
//strut(ring_r = 40);
//tracer_inner_shell();


module tracer_plate(t=2) {
    
translate([0,0,0]) {
    
difference() {
    cylinder(r=shell_r, h=t);
        tracer_center_hole();
}

spinners=4;
spinner_angle = 360/spinners;
protrusion = 5;

for (i = [1:spinners] ) {
    lead_inset = i * protrusion+6;
    echo("lead inset");
    echo(lead_inset);
    
    rotate(spinner_angle*i, [0,0,1]) {
    translate([shell_r-4,0,-20])
    cylinder(r=3, h=20);
    }
    rotate(spinner_angle*i+spinner_angle/3, [0,0,1]) {
    translate([shell_r-lead_inset-4,-0,0])
        difference() {
            translate([lead_inset/2,0,t/2])
            cube([lead_inset,5,t], center=true);
            translate([3,0,0])
            cylinder(r=1.8, h=20, center=true);
        }
    }
}

}
}

//tracer_plate();

module spinner_strut(h=60, r1 = 40, r2=2, hole_r=1, wall = 1) {

    strut(ring_r = 45);
    translate([0,0,1])
    tracer_journal();
}

//spinner_strut();
//translate([0,0,-3])
tracer_inner_shell();

translate([0,0,-10])
