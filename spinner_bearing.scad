include <settings.scad>
include <hollow_bearing.scad>
use <v_pulleys.scad>

$fa=1; $fs=.5;

inner_hole_r = 35;
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

spinner_pulley_t = 5;
spinner_single_pulley_t = 6;
spinner_pulley_attach = .1;

spinner_pulley_center_z = shell_t+journal_t/2+journal_tolerance_z/2+spinner_pulley_t/2-spinner_pulley_attach;
//spinner_pulley_center_z =0;
//spinner_pulley_center_z =0;
/*
shell_r = inner_hole_r + inner_shell_wall + outer_shell_wall + inner_outer_tolerance + flange_w ;
inner_shell_h = journal_t + shell_t*2 + retainer_t*2 + journal_tolerance_z+retainer_tolerance*2;
outer_shell_h = journal_t + shell_t +journal_tolerance_z;

*/

spinner_key_t = 2;
spinner_key_insert = 4;

module spinner_connect_holes() {
         translate([-inner_hole_r+2,0,-spinner_pulley_t+spinner_pulley_attach])
            cylinder(r=1.5,h=20,center=true);
         translate([inner_hole_r-2,0,-spinner_pulley_t+spinner_pulley_attach])
            cylinder(r=1.5,h=20,center=true);
}

module spinner_connect_tabs() {
    difference() {
        union() {
            translate([inner_hole_r,0,-spinner_pulley_t+spinner_pulley_attach])
                cylinder(r=5,h=2);
            translate([-inner_hole_r,0,-spinner_pulley_t+spinner_pulley_attach])
                cylinder(r=5,h=2);
        }
        spinner_connect_holes();
    }    
}
//spinner_connect_tabs();
module spinner_key(t=spinner_key_t, tol=0) {
    difference() {
        union() {
    difference() {
        union() {
        translate([0,0,-t/2])
            cylinder(r=shell_r, h=t, center=true);
            
        translate([0,0,spinner_key_insert/2])
            cylinder(r=inner_hole_r-tol/2, h=spinner_key_insert, center=true);
            
        translate([0,0,spinner_key_insert/2-smidge])
            cylinder(r=inner_hole_r-tol/2, h=spinner_key_insert, center=true);


            
        }
cylinder(r=inner_hole_r-tol/2-t, h=20, center=true);    
    }
    intersection() {
            translate([inner_hole_r,0,+(spinner_key_insert-t)/2])
                cylinder(r=5+t,h=t+spinner_key_insert, center=true);
            cylinder(r=inner_hole_r-tol/2, h=spinner_key_insert*2, center=true);
    }
    intersection() {
            translate([-inner_hole_r,0,+(spinner_key_insert-t)/2])
                cylinder(r=5+t,h=t+spinner_key_insert, center=true);
            cylinder(r=inner_hole_r-tol/2, h=spinner_key_insert*2, center=true);
    }
}
    translate([inner_hole_r,0,+(spinner_key_insert-t)/2+t])
        cylinder(r=5+tol/2,h=t+spinner_key_insert, center=true);
    translate([-inner_hole_r,0,+(spinner_key_insert-t)/2+t])
        cylinder(r=5+tol/2,h=t+spinner_key_insert, center=true);
         spinner_connect_holes();   
    }
}
//translate([0,0,-shell_t-journal_t/2-journal_tolerance_z/2-spinner_pulley_t/2-spinner_pulley_t+spinner_pulley_attach])
//!spinner_key();

module spinner_inner_shell() {

    inner_shell();
    translate([0,0,-spinner_pulley_t/2+spinner_pulley_attach])
    belt_pulley(
        d = shell_r*2-4,
        shaft_d=inner_hole_r*2,
        belt_width=2,
        t= spinner_pulley_t,
        wedge_factor=.4
    );
    spinner_connect_tabs();
}

//spinner_inner_shell();

module spinner_outer_shell() {
    outer_shell();
}

module spinner_journal() {
    journal();

}

module spinner_retainer_ring() {
    retainer_ring();
}

//module spinner_center_hole() {
//    center_hole();
//}

module spinner_bearing_assembly() {
//intersection() {
translate([0,0,shell_t+journal_t/2+journal_tolerance_z/2])
spinner_outer_shell();

    translate([0,0,-shell_t-journal_t/2-journal_tolerance_z/2]) {
    spinner_inner_shell();

   translate_retainer()
  spinner_retainer_ring();
}

//translate([0,0,-shell_t-journal_t/2-journal_tolerance_z/2-spinner_pulley_t+spinner_pulley_attach-1])
//spinner_key(tol=2);
    

spinner_journal();
//}

}
//spinner_center_hole();
//!spinner_bearing_assembly();

module spinner_bearing_print_all() {
translate([0,0,0])
rotate(180, [0,1,0])
spinner_outer_shell();
translate([shell_r*2+4,0,spinner_pulley_t-spinner_pulley_attach]) 
    spinner_inner_shell();
    
//translate([0,shell_r*2+flange_w*2,journal_t/2])
//spinner_journal();
//translate([shell_r+flange_w*3+inner_hole_r,shell_r+flange_w*2+inner_hole_r,retainer_t/2])
translate([shell_r+flange_w,shell_r+inner_hole_r,retainer_t/2])
spinner_retainer_ring();
    
}


//spinner_bearing_print_all();

