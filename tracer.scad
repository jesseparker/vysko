include <strut_tracer.scad>
include <tracer_bearing.scad>
include <tracer_plate.scad>

strut_tracer();

tracer_bearing_assembly();

translate([0,0,-15])
tracer_plate();
