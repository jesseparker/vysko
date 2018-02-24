include <tracer_bearing.scad>
include <strut.scad>

strut(ring_r = 45, meat_factor = .7, h=3);
translate([0,0,1.5])
tracer_journal();
