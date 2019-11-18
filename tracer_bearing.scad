include <hollow_bearing.scad>
use <rb-pulleys.scad>

$fn = 100;
inner_hole_r = 35;
shell_wall = 2;
inner_shell_wall = shell_wall;
outer_shell_wall = shell_wall/2;
shell_t = 2; 
flange_w = shell_t*2;
inner_outer_tolerance = .8;
journal_t = 3;
journal_tolerance = 1.2;
journal_tolerance_z = .6;

retainer_t = 1;
retainer_d = inner_shell_wall /2;
retainer_w = retainer_d*2+inner_outer_tolerance;
retainer_tolerance=.4;

tracer_pulley_t = 5;
tracer_single_pulley_t = 7;
tracer_pulley_attach = .1;

tracer_pulley_center_z = shell_t+journal_t/2+journal_tolerance_z/2+tracer_pulley_t/2-tracer_pulley_attach;
//tracer_pulley_center_z =0;
//tracer_pulley_center_z =0;
/*
shell_r = inner_hole_r + inner_shell_wall + outer_shell_wall + inner_outer_tolerance + flange_w ;
inner_shell_h = journal_t + shell_t*2 + retainer_t*2 + journal_tolerance_z+retainer_tolerance*2;
outer_shell_h = journal_t + shell_t +journal_tolerance_z;

*/

module tracer_connect_tabs() {
    difference() {
        union() {
            translate([inner_hole_r,0,-tracer_pulley_t+tracer_pulley_attach])
                cylinder(r=5,h=2);
            translate([-inner_hole_r,0,-tracer_pulley_t+tracer_pulley_attach])
                cylinder(r=5,h=2);
        }
         translate([-inner_hole_r+2,0,-tracer_pulley_t+tracer_pulley_attach])
            cylinder(r=1.5,h=10,center=true);
         translate([inner_hole_r-2,0,-tracer_pulley_t+tracer_pulley_attach])
            cylinder(r=1.5,h=10,center=true);
    }    
}
module tracer_inner_shell() {

    inner_shell();
    translate([0,0,-tracer_pulley_t/2+tracer_pulley_attach])
    belt_pulley(
        d = shell_r*2-4,
        shaft_d=inner_hole_r*2,
        belt_width=3,
        slope=.5,
        t= tracer_pulley_t
    );
    tracer_connect_tabs();
}

//tracer_inner_shell();

module tracer_outer_shell() {
    outer_shell();
}

module tracer_journal() {
    journal();

}

module tracer_retainer_ring() {
    retainer_ring();
}

module tracer_center_hole() {
    center_hole();
}

module tracer_bearing_assembly() {
//intersection() {
translate([0,0,shell_t+journal_t/2+journal_tolerance_z/2])
tracer_outer_shell();

    translate([0,0,-shell_t-journal_t/2-journal_tolerance_z/2]) {
    tracer_inner_shell();
   translate_retainer()
tracer_retainer_ring();
}
    

tracer_journal();
//}

}
//tracer_bearing_assembly();

module tracer_bearing_print_all() {
translate([0,0,0])
rotate(180, [0,1,0])
tracer_outer_shell();
translate([shell_r*2+4,0,tracer_pulley_t-tracer_pulley_attach]) 
    tracer_inner_shell();
    
translate([0,shell_r*2+flange_w*2,journal_t/2])
tracer_journal();
translate([shell_r+flange_w*3+inner_hole_r,shell_r+flange_w*2+inner_hole_r,retainer_t/2])
tracer_retainer_ring();
    
}


//tracer_bearing_print_all();

