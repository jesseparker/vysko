include <trapezoid_groove.scad>

inner_hole_r = 10;
shell_wall = 2;
inner_shell_wall = shell_wall;
outer_shell_wall = shell_wall/2;
shell_t = 2; 
flange_w = shell_t*2;
inner_outer_tolerance = .8;
journal_t = 2;
journal_tolerance = 1.2;
journal_tolerance_z = .6;

retainer_t = 1;
retainer_d = inner_shell_wall /2;
retainer_w = retainer_d*2+inner_outer_tolerance;
retainer_tolerance=.4;

shell_r = inner_hole_r + inner_shell_wall + outer_shell_wall + inner_outer_tolerance + flange_w ;
inner_shell_h = journal_t + shell_t*2 + retainer_t*2 + journal_tolerance_z+retainer_tolerance*2;
outer_shell_h = journal_t + shell_t +journal_tolerance_z;


module center_hole(r=inner_hole_r, h=inner_shell_h*8) {
      cylinder(r=r, h=h, center=true);  
}

module retainer_slot(r=inner_hole_r+shell_wall-retainer_d, h=retainer_t+retainer_tolerance) {
    trapezoid_groove(
        d = r*2,
        belt_width=h,
        slope=.4
    );
}

module retainer_ring(r=inner_hole_r+shell_wall-retainer_d, h=retainer_t) {
    difference() {
        cylinder(r=r+retainer_w, h=h, center=true);  
        cylinder(r=r, h=h*2, center=true);
        translate([r+retainer_w/2,0,0])  
            cube([retainer_d*4,retainer_w/2,retainer_t*2], center=true);
    }
}

module translate_retainer() {
        translate([0,0,shell_t*2+journal_t+journal_tolerance_z+retainer_tolerance+retainer_t/2])
        children();
}


module inner_shell(extra_length = 0) {
    //translate([0,0,inner_shell_h/2])
    difference() {
        union() {
            cylinder(r=inner_hole_r+shell_wall, h=inner_shell_h+extra_length);
            //translate([0,0,-inner_shell_h/2+shell_t/2])
           cylinder(r=shell_r, h=shell_t);
        } 
        
        center_hole(r=inner_hole_r);
        translate_retainer()
        retainer_slot();
    }
}

module outer_shell_hole(r=inner_hole_r+inner_shell_wall+inner_outer_tolerance/2, h=60) {
      cylinder(r=r, h=h, center=true);  
}

module outer_shell() {
    translate([0,0,-outer_shell_h/2])
    difference() {
        union() {
            cylinder(r=inner_hole_r+inner_shell_wall+inner_outer_tolerance+outer_shell_wall, h=outer_shell_h, center=true);
            translate([0,0,outer_shell_h/2-shell_t/2])
           cylinder(r=shell_r, h=shell_t, center=true);
        } 
        
        outer_shell_hole();
    }
}

module journal_hole(r=inner_hole_r+inner_shell_wall+outer_shell_wall+journal_tolerance/2+inner_outer_tolerance, h=60) {
      cylinder(r=r, h=h, center=true);  
}

module journal(r = shell_r+flange_w, t = journal_t) {
    difference() {
    cylinder (r=r, h = t, center=true);
        journal_hole();
    }
}



module hollow_bearing_assembly() {
    rotate(180, [0,1,0]) {
        
//intersection() {
translate([0,0,shell_t+journal_t/2+journal_tolerance_z/2])
outer_shell();

    translate([0,0,-shell_t-journal_t/2-journal_tolerance_z/2]) {
    inner_shell();
   translate_retainer()
retainer_ring();
}
    

journal();
//}
}
}
//hollow_bearing_assembly();


module hollow_bearing_print_all() {
translate([0,0,0])
rotate(180, [0,1,0])
outer_shell();
translate([shell_r*2+4,0,0]) 
    inner_shell();
    
translate([0,shell_r*2+flange_w*2,journal_t/2])
journal();
translate([shell_r+flange_w*3+inner_hole_r,shell_r+flange_w*2+inner_hole_r,retainer_t/2])
retainer_ring();
    
}


//hollow_bearing_print_all();
