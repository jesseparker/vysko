include <settings.scad>
include <strut.scad>
include <spinner_bearing.scad>

//$fn=100;
$fa=1; $fs=.5;

difference() {
    strut_spinner(ring_r = 50, meat_factor = .8, h=journal_t,do_bearing = 0);
    journal_hole();
}
//translate([0,0,journal_t/2])
//spinner_journal();
