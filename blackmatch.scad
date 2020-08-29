include <spool.scad>
include <jplib.scad>

spool_h = 30;
spool_z = 1; // space spool-retainer

spools=3;//+1
die_d = 1.8;
die_t = 5;
die_margin = 4;
under_z=1;

oa_length=120;
oa_height=80;
oa_width=70;

side_t=5;
side_r=5;
side_z_offset = 20;



roller_d = 12;
roller_hole_d=8;
//roller_wall = roller_d/2-roller_hole_d/2;

roller_shaft_d=6;
roller_shaft_hole_d=roller_shaft_d+1;

roller_offset = (roller_hole_d - roller_shaft_hole_d)/2;

retainer_height = 5;
retainer_engagement = side_t/2;
//retainer_engagement = 1;

roller_length=oa_length-roller_offset-die_t-die_margin*2;
roller_height=oa_height+roller_d/2-roller_offset-spool_h-spool_z-retainer_engagement-under_z;
roller_width=oa_width-side_t*2-3;


body_width = oa_width - 5;
body_length = roller_length - roller_d*2 - roller_offset*2 -5;
body_height = roller_height-roller_d;



retainer_width = body_width+side_t*3;
retainer_length = body_length;

retainer_z = 2;



module corner_translate() {
    for (i = [1,-1]) {
        for (j = [1,-1]) {
            translate([i*oa_length/2-i*side_r,j*oa_height/2-j*side_r,0])
                children();
        }        
    }
}


module side(right=1, tol=0) {
    r=side_r;
    l=oa_length;
    h=oa_height;
    t=side_t;
    
    side_z = oa_height/2-roller_height/2+roller_offset-under_z;
    
    side_forward = die_t/2*die_margin;
    side_forward = (die_margin*2+die_t)/2;
    //rotate(90,[1,0,0])
    //translate([0,h/2,0])
    difference() {
        //translate([6,9,(oa_width/2-side_t/2)*right])
        translate([side_forward,side_z,(oa_width/2-side_t/2)*right])
            tablet([oa_length,oa_height,side_t]);
       // hull() {
       //         corner_translate()
       //                 cylinder(r=r, h=t+tol, center=true);
       // }
        roller_axle_holes();
        die(tol=1);
        body(tol=1);
        retainer_blank(tol=1);
        under_relief();
        }
}
module sides(tol=0) {
    side(tol=tol);
    side(right=-1, tol=tol);    
}

module roller() {
    //rotate(90, [1,0,0])
    difference() {
        cylinder(h=roller_width, r=roller_d/2, center=true);
        cylinder(h=roller_width+1, r=roller_shaft_hole_d/2, center=true);

    }    
}

module roller_axle_hole() {
         cylinder(h=oa_width+1, r=roller_shaft_hole_d/2, center=true);
}

module roller_axle_holes() {
    roller_axle_translate() roller_axle_hole();
}
module roller_axle() {
         cylinder(h=oa_width+8, r=roller_shaft_d/2, center=true);
    
}
module roller_axles() {
    roller_axle_translate() roller_axle();
}
module roller_axle_translate() {
    slip = roller_offset;
    
    for (i = [1,-1]) {
        for (j = [1,-1]) {
            translate([i*roller_length/2-i*roller_d/2,j*roller_height/2-j*roller_d/2,0])
                children();
        }        
    }
}


module rollers() {
    roller_translate() roller();
}

module roller_translate() {
    slip = roller_offset;
    
    for (i = [1,-1]) {
        for (j = [1,-1]) {
            translate([i*roller_length/2-i*roller_d/2-i*slip,j*roller_height/2-j*roller_d/2-j*slip,0])
                children();
        }        
    }
}

//rollers();
module under_relief() {
    xd = sqrt(2*body_length*body_length)/2;
    xs = body_length/2*.7;
    
    yd = sqrt(2*body_width*body_width)/2;
    ys = body_width/2*0.7;

    translate([0,-body_height/2-xd+xs,0])
        rotate(45, z_axis)
            cube([body_length,body_length,oa_width+1],center=true);
    translate([0,-body_height/2-yd+ys,0])
        rotate(45, x_axis)
            cube([body_length+1,body_width,body_width],center=true);
 
}

module body(tol=0) {
    //cube([body_length,body_height,body_width], center=true);
    difference() {
        rotate(90, x_axis)
            tablet([body_length+tol,body_width+tol,body_height+tol]);
        under_relief();
    }
    spool_translate()
        spool_holder();
}

//!body();

module spool_translate() {
    spool_od = spool_d * flange_ratio * 2 ;
    
    run_x=body_length - spool_od - 2;
    run_y=body_width - spool_od - 2-side_t;
    spool_x=run_x/(spools);
    spool_y=run_y/(spools);
    translate([0,body_height/2+spool_h,0])
    rotate(90, [1,0,0])
    translate([-run_x/2,-run_y/2,0])
    for(i=[0:spools]) {
        translate([i*spool_x,i*spool_y,0])
            children();
    }
}
module spool_holder() {
    spool_shaft();
    //spool();
}


module die(tol=0) {
    translate([roller_length/2-roller_offset+die_t/2+die_margin,roller_height/2+roller_offset+die_d/2,0])
       rotate(90,[0,0,1])
    rotate(90,[1,0,0])
    difference() {
            tablet([20,oa_width-side_t,die_t+tol], center=true);
        cylinder(r=die_d/2, h=30, center=true);
        translate([0,die_d*3,0])
            cylinder(r=die_d/2*1.1, h=30, center=true);
        translate([0,die_d*6,0])
            cylinder(r=die_d/2*1.2, h=30, center=true);
        translate([0,-die_d*3,0])
            cylinder(r=die_d/2*0.9, h=30, center=true);
        translate([0,-die_d*6,0])
            cylinder(r=die_d/2*0.8, h=30, center=true);

    }        
}

module retainer_blank(tol=0) {
    translate([0,body_height/2+spool_h+retainer_height/2+retainer_z,0])
    rotate(90,[1,0,0])
        tablet([retainer_length+tol,retainer_width,retainer_height], center=true);
}
module retainer(tol=0) {
    difference() {
        retainer_blank(tol=tol);
        translate([0,retainer_engagement,0])
            sides(tol=1);
    }
}

module spools() {
    spool_translate() spool();
}

module main() {
    //color(c = [ 0.7, 0.5, 0.4, .5])
    rollers();
    spools();
    roller_axles();
    die();
    //translate([0,20,0])
    retainer();
    //color(c = [ 0.7, 0.5, 0.4, .2])
    sides();
    body();
}


//secondary_as_cube = false;
//giftwrap(tail=[0,1,0])
main();


module to_print() {
//rotate(180,x_axis)
//translate([0,0,-oa_width/2])
//side();

//translate([0,0,oa_width/2])
//side(right=-1);

//translate([0,0,body_height/2])
//rotate(90,x_axis)
//body();

//rotate(-90,x_axis)
//translate([0,-roller_height/2-spool_h-spool_z+roller_d/2-under_z-retainer_height,0])
//retainer();

//rotate(-90,y_axis)
//translate([-roller_length/2-die_t/2-die_margin+die_t/2,-roller_height/2+roller_offset-die_d/2,0])
//die();

//for(i=[0:3]) { translate([i*spool_d*1.6,0,0]) spool(); }
//spool();

//for(i=[0:3]) { translate([i*roller_d*1.4,0,0]) translate([0,0,roller_width/2])
    //roller();
//    }
}

//to_print();