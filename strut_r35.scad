include <tracer_bearing.scad>
include <strut.scad>
//$fn=100;

strut(ring_r = 45, meat_factor = .7, h=journal_t,do_bearing = 0);
translate([0,0,journal_t/2])
tracer_journal();
