// <senorjp@gmail.com> July 2016
// Visco fuse spinner
//$fn = 100;
include <settings.scad>

use <hollow-bearings.scad>
use <spool.scad>
use <rb-pulleys.scad>
use <spinning_plate.scad>

///// You can change these values easily /////

frame_x = 6*25.4;
frame_y = frame_x;
frame_rod_diameter=5;
frame_rod_h = 800;

drive_shaft_disp_x = frame_x/2 -frame_rod_diameter*2 - 20;
drive_shaft_disp_y = -frame_y/2 +frame_rod_diameter*2;



module frame_rod() {
cylinder(r=frame_rod_diameter/2, h=frame_rod_h, center=true);
}

module frame_rods() {
x_disp = frame_x/2 - frame_rod_diameter*2;
y_disp = frame_y/2 -frame_rod_diameter*2;

translate([x_disp,y_disp,0])
frame_rod();
translate([-x_disp,y_disp,0])
frame_rod();
translate([-x_disp,-y_disp,0])
frame_rod();
translate([x_disp,-y_disp,0])
frame_rod();

// Drive shaft
translate([drive_shaft_disp_x,drive_shaft_disp_y])
frame_rod();
 
translate([0,0,0])
cylinder(r=1, h=frame_rod_h, center=true);


}

module upper_spinning_strut() {

    difference() {
        cube([frame_x,frame_y,6], center=true);
        inner_negative();
        frame_rods();
    }

}

module tracer_strut(
    hole_diameter=hole_diameter,
    bearing_diameter=bearing_diameter,
    bearing_race_diameter=bearing_race_diameter
) {

    difference() {
        cube([frame_x,frame_y,6], center=true);
        inner_negative(hole_diameter=hole_diameter);
        frame_rods();
    }

}

module tracer_plate() {
    num_tracers=5;
    angle=360/num_tracers;
    difference() {
        union() {
            cylinder(r=65,h=6);
            
            for(a=[0:angle:360]) {
                rotate(a,[0,0,1])
                translate([50,0,0])
                cylinder(r=6,h=30);
            }           
        }
        negative(hole_diameter=hole_diameter);
   }
}





module assembly(
    hole_diameter=hole_diameter,
    bearing_diameter=bearing_diameter,
    bearing_race_diameter=bearing_race_diameter
) {

s=70;
    
    
    //// Tracer ////////
    translate([0,0,380])
    tracer_plate(hole_diameter=s);


    translate([0,0,360])
    inner_raceway(hole_diameter=s);

    translate([0,0,340])
    tracer_strut(
        hole_diameter=s,
        bearing_diameter=bearing_diameter,
        bearing_race_diameter=bearing_race_diameter
    );


    translate([0,0,320])
    rotate(180,[1,0,0])
    inner_raceway(hole_diameter=s);
    
   
    translate([0,0,300])
    raceway(hole_diameter=s);




    //// Upper spinner /////
    
    translate([0,0,230])
    spinning_plate();

    translate([0,0,210])
    inner_raceway();

    translate([0,0,190])
    upper_spinning_strut();

    translate([0,0,170])
    rotate(180,[1,0,0])
    inner_raceway(hole_diameter=hole_diameter, bearing_diameter=bearing_diameter);


    translate([0,0,150])
    raceway(hole_diameter=hole_diameter, bearing_diameter=bearing_diameter);




    /// Lower spinner ///
    translate([0,0,80])
    spinning_plate();

    translate([0,0,60])
    inner_raceway();

    translate([0,0,40])
    upper_spinning_strut();

    translate([0,0,20])
    rotate(180,[1,0,0])
    inner_raceway(hole_diameter=hole_diameter, bearing_diameter=bearing_diameter);



    translate([0,0,0])
    raceway(hole_diameter=hole_diameter, bearing_diameter=bearing_diameter);



    color("Gray") frame_rods();
}


//raceway(hole_diameter=80);
//spool();
//spinning_plate(t=20);

//pair_to_print(hole_diameter=80);
assembly();

puller_d=50;
puller_h=40;
puller_flange=10;

translate([0,0,-50])
translate([puller_d/2,(puller_h-puller_flange)/2,0])
    rotate(90,[1,0,0])
difference() {
union() {
    cylinder(r=puller_d/2, h=puller_h, center=true);
    
    translate([0,0,puller_h/2])
    cylinder(r=puller_d/2+puller_flange, h=puller_flange,center=true);
    
    translate([0,0,-puller_h/2])
    cylinder(r=puller_d/2+puller_flange, h=puller_flange,center=true);
}
    translate([0,0,-puller_h/2])
    belt_groove(d=puller_d+puller_flange);

    cylinder(r=5,h=puller_h*2,center=true);
}

    translate([drive_shaft_disp_x,drive_shaft_disp_y,0])
belt_pulley();

    translate([-10,30,0])
rotate(90,[0,1,0])
belt_pulley();
