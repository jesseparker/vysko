include <settings.scad>;
use <gears/gears.scad>;
include <rods.scad>;

/*
bevel_gear_pair(modul=3.1, gear_teeth=31, pinion_teeth=11, axis_angle=90, tooth_width=6, bore=4, pressure_angle = 20, helix_angle=20, together_built=true);
//3.1 = d/11
//d=3.1*11
translate([0,0,-9])
cylinder(r=(3.1*31)/2, h=10, center=true);
*/

frame_rods();


gear_ratio = 1/3;
smidge=.001;
gear_t=5;

gear_d = 30;

gear_offset = gear_d-(gear_d*gear_ratio/2);

module fakegear(h=gear_t, d=gear_d, ratio=gear_ratio) {
    translate([0,0,h/2])
    cylinder(r=d/2, h=h, center=true);
    translate([0,0,h+h/2-smidge])
    cylinder(r=d*ratio/2, h=h, center=true);
}
translate([drive_position_x-20/2-gear_d/2,drive_position_y,0])
fakegear();

translate([drive_position_x-20/2-gear_d/2-gear_offset,0,gear_t])
fakegear();

translate([drive_position_x-20/2-gear_d/2-gear_offset,gear_offset,gear_t*2])
fakegear();

// horizontal
translate([drive_position_x,drive_position_y,0])
cylinder(r=20/2, h=gear_t, center=true);

puller_w=(drive_position_x-20/2-gear_d/2-gear_offset-gear_d*gear_ratio/2)*2;

//pull wheel
translate([0,gear_offset,gear_t*3+gear_offset])
rotate(90,[0,1,0])
cylinder(r=gear_offset, h=puller_w, center=true);

translate([0,-gear_offset,gear_t*3+gear_offset])
rotate(90,[0,1,0])
cylinder(r=gear_offset, h=puller_w, center=true);
