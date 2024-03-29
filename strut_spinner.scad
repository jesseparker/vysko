include <settings.scad>
include <strut.scad>
include <spinner_bearing.scad>

//$fn=100;
$fa=1; $fs=.5;

module spinner_strut_part() {
    
difference() {
    strut_spinner(ring_r = 50, meat_factor = .8);
    journal_hole();
}

}

spinner_strut_part();

//translate([0,0,journal_t/2])
//spinner_journal();
