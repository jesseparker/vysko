include <settings.scad>
include <hollow_bearing.scad>
use <v_pulleys.scad>

//$fa=1; $fs=.5;
$fa=3; $fs=2;

inner_hole_r = tracer_center_hole_r;
shell_wall = 2;
inner_shell_wall = shell_wall;
outer_shell_wall = shell_wall/2;
shell_t = 2; 
flange_w = shell_t*2;
inner_outer_tolerance = 1;
journal_t = strut_t;
journal_tolerance = 1;
journal_tolerance_z = lh;

retainer_t = layer_multiple(1);
retainer_d = inner_shell_wall /2;
retainer_w = retainer_d*2+inner_outer_tolerance;
retainer_tolerance=.1;

tracer_pulley_t = 5;
tracer_single_pulley_t = 6;
tracer_pulley_attach = .1;

tracer_pulley_center_z = shell_t+journal_t/2+journal_tolerance_z/2+tracer_pulley_t/2-tracer_pulley_attach;
//tracer_pulley_center_z =0;
//tracer_pulley_center_z =0;
/*
shell_r = inner_hole_r + inner_shell_wall + outer_shell_wall + inner_outer_tolerance + flange_w ;
inner_shell_h = journal_t + shell_t*2 + retainer_t*2 + journal_tolerance_z+retainer_tolerance*2;
outer_shell_h = journal_t + shell_t +journal_tolerance_z;

*/

tracer_key_t = 1.5;
tracer_key_insert = 4;

module tracer_connect_holes() {
         translate([-inner_hole_r+2,0,-tracer_pulley_t+tracer_pulley_attach])
            cylinder(r=1.5,h=20,center=true);
         translate([inner_hole_r-2,0,-tracer_pulley_t+tracer_pulley_attach])
            cylinder(r=1.5,h=20,center=true);
}

module tracer_connect_tabs() {
    difference() {
        union() {
            translate([inner_hole_r,0,-tracer_pulley_t+tracer_pulley_attach])
                cylinder(r=5,h=2);
            translate([-inner_hole_r,0,-tracer_pulley_t+tracer_pulley_attach])
                cylinder(r=5,h=2);
        }
        tracer_connect_holes();
    }    
}
//tracer_connect_tabs();
module tracer_key(t=tracer_key_t, tol=0) {
    difference() {
        union() {
    difference() {
        union() {
        translate([0,0,-t/2])
            cylinder(r=shell_r, h=t, center=true);
            
        translate([0,0,tracer_key_insert/2])
            cylinder(r=inner_hole_r-tol/2, h=tracer_key_insert, center=true);
            
      //  translate([0,0,tracer_key_insert/2-smidge])
      //      cylinder(r=inner_hole_r-tol/2, h=tracer_key_insert, center=true);


            
        }
cylinder(r=inner_hole_r-tol/2-t, h=20, center=true);    
    }
    intersection() {
            translate([inner_hole_r,0,+(tracer_key_insert-t)/2])
                cylinder(r=5+t+tol/2,h=t+tracer_key_insert, center=true);
            cylinder(r=inner_hole_r-tol/2, h=tracer_key_insert*2, center=true);
    }
    intersection() {
            translate([-inner_hole_r,0,+(tracer_key_insert-t)/2])
                cylinder(r=5+t+tol/2,h=t+tracer_key_insert, center=true);
            cylinder(r=inner_hole_r-tol/2, h=tracer_key_insert*2, center=true);
    }
}
    translate([inner_hole_r,0,+(tracer_key_insert-t)/2+t])
        cylinder(r=5+tol/2,h=t+tracer_key_insert, center=true);
    translate([-inner_hole_r,0,+(tracer_key_insert-t)/2+t])
        cylinder(r=5+tol/2,h=t+tracer_key_insert, center=true);
         tracer_connect_holes();   
    }
}
//translate([0,0,-shell_t-journal_t/2-journal_tolerance_z/2-tracer_pulley_t/2-tracer_pulley_t+tracer_pulley_attach])
//!tracer_key();

module tracer_inner_shell() {

    inner_shell();
    translate([0,0,-tracer_pulley_t/2+tracer_pulley_attach])
    belt_pulley(
        d = shell_r*2-4,
        shaft_d=inner_hole_r*2,
        belt_d=2,
        t= tracer_pulley_t,
        wedge_factor=.4
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

//module tracer_center_hole() {
//    center_hole();
//}

module tracer_bearing_assembly() {
    
//intersection() {
//translate([0,0,shell_t+journal_t/2+journal_tolerance_z/2])
//tracer_outer_shell();
    rotate(180,[1,0,0])
    translate([0,0,-shell_t-journal_t/2-journal_tolerance_z/2]) {
        tracer_inner_shell();

        translate_retainer()
            tracer_retainer_ring();
    }

//color("red")
    rotate(180,[1,0,0])
translate([0,0,-shell_t-journal_t/2-journal_tolerance_z/2-tracer_pulley_t+tracer_pulley_attach-1])
tracer_key(tol=3);
   // }

//tracer_journal();
//}

}
//tracer_center_hole();
//tracer_bearing_assembly();

module tracer_bearing_print_all() {
translate([0,0,0])
rotate(180, [0,1,0])
tracer_outer_shell();
translate([shell_r*2+4,0,tracer_pulley_t-tracer_pulley_attach]) 
    tracer_inner_shell();
    
//translate([0,shell_r*2+flange_w*2,journal_t/2])
//tracer_journal();
translate([shell_r+flange_w*3+inner_hole_r,shell_r+flange_w*2+inner_hole_r,retainer_t/2])
//translate([shell_r+flange_w,shell_r+inner_hole_r,retainer_t/2])
tracer_retainer_ring();

    translate([0,shell_r+flange_w*2+inner_hole_r+4,tracer_pulley_t-tracer_pulley_attach])
    tracer_key();
}


//tracer_bearing_print_all();

