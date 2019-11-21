include <settings.scad>;
use <gears/gears.scad>;
include <rods.scad>;

bevel_gear_pair(modul=3.1, gear_teeth=11, pinion_teeth=11, axis_angle=90, tooth_width=6, bore=4, pressure_angle = 20, helix_angle=20, together_built=true);

frame_rods();

puller_d=30;
puller_w=20;

train_x=drive_position_x-puller_w/2;
train_y=puller_d/2;

gear_ratio = 1/2;


gear_d_lg = train_x/(1.5+1*gear_ratio);
gear_ratio = 1/2;
gear_d_sm = gear_d_lg * gear_ratio;

gear_b_y = gear_d_sm/2+gear_d_lg/2;

gear_b_x = drive_position_x-gear_d_lg-gear_d_sm/2-gear_d_lg/2;

// horizontal
translate([drive_position_x,drive_position_y,100])
cylinder(r=gear_d_lg/2, h=10, center=true);

//  a
translate([drive_position_x-gear_d_lg,0,100])
cylinder(r=gear_d_lg/2, h=10, center=true);

translate([drive_position_x-gear_d_lg,0,100-10])
cylinder(r=gear_d_sm/2, h=10, center=true);

// b
translate([drive_position_x-gear_d_lg,gear_b_y,100-10])
cylinder(r=gear_d_lg/2, h=10, center=true);

translate([drive_position_x-gear_d_lg,gear_b_y,100])
cylinder(r=gear_d_sm/2, h=10, center=true);

// c
translate([gear_b_x,gear_b_y,100])
cylinder(r=gear_d_lg/2, h=10, center=true);

translate([gear_b_x,gear_b_y,100-10])
cylinder(r=gear_d_sm/2, h=10, center=true);

//pull wheel
translate([0,20,100-20])
rotate(90,[0,1,0])
cylinder(r=puller_d/2, h=puller_w, center=true);
translate([0,-20,100-20])
rotate(90,[0,1,0])
cylinder(r=puller_d/2, h=puller_w, center=true);