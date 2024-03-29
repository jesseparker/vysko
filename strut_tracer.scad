include <settings.scad>
use <strut.scad>
use <tracer_bearing.scad>

//$fn=100;
$fa=1; $fs=.5;

module strut_tracer() {
rotate(180,[1,0,0])
difference() {
    strut_spinner(ring_r = tracer_center_hole_r, meat_factor = 3);
    journal_hole();
}
//translate([0,0,journal_t/2])
//spinner_journal();
}

//strut_tracer();