include <settings.scad>
include <strut.scad>
include <tracer_bearing.scad>

//$fn=100;
$fa=1; $fs=.5;

module strut_tracer() {
    
difference() {
    strut_spinner(ring_r = tracer_center_hole_r, meat_factor = 3, h=journal_t,do_bearing = 0);
    journal_hole();
}
//translate([0,0,journal_t/2])
//spinner_journal();
}

