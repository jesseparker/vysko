include <tracer_bearing.scad>
include <strut.scad>

strut(ring_r = 45, meat_factor = .5, h=2);
translate([0,0,1])
tracer_journal();
