include <jplib.scad>
include <v_pulleys.scad>
include <driveshaft_pulley.scad>

gm_major_diameter=38.5;
gm_major_length= 65;
gm_shaft_offset = 8;

module dshaft(d = 6, dee = 0.7, h = 5.8, tol=0){
    difference() {
    cylinder(r=d/2+tol/2, h=h, center=true);
        translate([d + d/2 - dee +tol/2 ,0,0])
        cube([d*2,d*2,h*2], center=true);
    }
}

module gm_shaft_disp() {
    translate([gm_shaft_offset,0,0]) children();
}
module 12vmotor(neg = false) {
    
cylinder(r=gm_major_diameter/2,h=25);
cylinder(r=34.5/2,h=53);
cylinder(r=11/2,h=56.5);
translate([10,0,55])    
    cube ([1,3,10], center=true);
translate([-10,0,55])    
    cube ([1,3,10], center=true);
if (neg) {
    cylinder(r=34.5/2,h=gm_major_length);
    //translate([0,0,1])
    //rotate(180,[0,1,0])
            //cylinder(r=32/2,h=12);
    
    translate([0,0,0.01])
gm_shaft_disp()
        rotate(180,[0,1,0])
            cylinder(r=11,h=18);

    //translate([0,0,-3])
    //rotate(180,[0,1,0])
            //cylinder(r=45/2,h=24);

}
gm_shaft_disp()
rotate(180,[0,1,0])
union() {
    cylinder(r=12/2,h=6);
    //cylinder(r=6/2,h=15);
translate([0,0,15/2])
        dshaft(h=15);
}
}


//rotate(180, x_axis)
//12vmotor(neg = false);
//%12vmotor(neg = true);

module motor_base() {
    expose=3;
    difference() {
        union() {
            translate([0,0,-gm_major_length/2-expose])
            cylinder(r=gm_major_diameter/2+6, h=gm_major_length, center=true);
            translate([0,0,-gm_major_length-expose+5])
            cylinder(r=gm_major_diameter/2+16, h=10, center=true);            
        }
    rotate(180, x_axis)
    12vmotor(neg = true);
        bolts=4;
        ang=360/bolts;
        for (i=[0:bolts-1]) {
            rotate(i*ang,z_axis)
            translate([gm_major_diameter/2+16/2+3,0,-gm_major_length])
            cylinder(r=3,h=20,center=true);
        
           }
           rotate(45,z_axis)
           translate([gm_major_diameter/4,0,-gm_major_length+5+expose])
        rotate(90,y_axis)
           cylinder(r=5, h=gm_major_diameter);
    }
}
//motor_base();

module motor_pulley() {
difference() {
    belt_pulley(d=20, t=7);
dshaft(h=10, tol=1); //tol=1 a bit too big maybe .7
}}
motor_pulley();

//driveshaft_pulley(d=50);