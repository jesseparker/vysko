include <settings.scad>
use <rods.scad>
use <bearing.scad>
use <driveshaft_pulley.scad>

//frame_rods();

use <tracer_bearing.scad>
use <tracer_plate.scad>
//use <strut.scad>
use <strut_tracer.scad>
use <sub_sidestrut.scad>

module sub_tracer() {

strut_tracer();

tracer_bearing_assembly();

translate([0,0,13])
    tracer_plate();

translate([0,0,-strut_t/2])
    sub_sidestrut();

translate([drive_position_x,drive_position_y,6])
    driveshaft_pulley();
}
    
sub_tracer();
    