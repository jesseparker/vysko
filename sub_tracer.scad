include <settings.scad>
use <rods.scad>
use <bearing.scad>
use <driveshaft_pulley.scad>

//frame_rods();

use <tracer_bearing.scad>
use <tracer_plate.scad>
use <strut.scad>
use <strut_tracer.scad>

module sub_tracer() {

strut_tracer();

translate([0,0,-strut_t])
    strut_side();
    
translate([drive_position_x,0,-drive_axle_bearing_t/2-bearing_pillow_side_t-strut_t/2])
    rotate(-90,[0,0,1])  
        bearing_pillow_top();

tracer_bearing_assembly();

translate([0,0,13])
    tracer_plate();

translate([drive_position_x,drive_position_y,6])
    driveshaft_pulley();
    }