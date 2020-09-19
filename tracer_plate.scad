include <tracer_bearing.scad>

$fn=50;


module tracer_plate(t=2) {
    
translate([0,0,0]) {
    translate([0,0,tracer_pulley_t-tracer_pulley_attach])
    rotate(15,[0,0,1])
    tracer_connect_tabs();
difference() {
    cylinder(r=shell_r, h=t);
        tracer_center_hole();
}

spinners=3;
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
            cube([lead_inset,8,t], center=true);
            translate([3,0,0])
            cylinder(r=2, h=20, center=true);
        }
    }
}

}
}

rotate(180,[1,0,0])
tracer_plate();


