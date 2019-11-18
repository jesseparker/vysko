$fn=30;
drive_axle_r = 8.1/2;
drive_axle_bearing_id = 8;
drive_axle_bearing_od = 22.5;
drive_axle_bearing_t = 8;

bearing_holder_wall = 1.2;
bearing_holder_tie_hole_r = 3/2;
bearing_holder_cut = -1;

bearing_pillow_rim_t = 2;
bearing_pillow_side_t = 1.5;
bearing_pillow_screw_thread_r = 3/2;
bearing_pillow_screw_shank_r = 4/2;
bearing_pillow_screw_head_r = 6/2;

module bearing(id = drive_axle_bearing_id, od = drive_axle_bearing_od, t = drive_axle_bearing_t) {
    difference() {
        cylinder(r=od/2, h=t, center=true);
        cylinder(r=id/2, h=t*2, center=true);
    }
}

module bearing_holder(
    od = drive_axle_bearing_od,
    t = drive_axle_bearing_t,
    wall=bearing_holder_wall,
    tie_hole_r = bearing_holder_tie_hole_r
) {
    extra_length = wall*4 + tie_hole_r*4;
    tie_width = wall*2 + tie_hole_r*6;
    difference() {
        union() {
            cylinder(r=od/2+wall, h=t+wall*2, center=true);
            cube([od+extra_length,tie_width,t+wall*2], center=true);
        }
        cylinder(r=od/2-wall, h=t*3, center=true);
        bearing();
        translate([od/2+wall+tie_hole_r,tie_hole_r*2,0])
        cylinder(r=tie_hole_r, h=t*2, center=true);
        translate([-od/2-wall-tie_hole_r,tie_hole_r*2,0])
        cylinder(r=tie_hole_r, h=t*2, center=true);

        translate([od/2+wall+tie_hole_r,-tie_hole_r*2,0])
        cylinder(r=tie_hole_r, h=t*2, center=true);
        translate([-od/2-wall-tie_hole_r,-tie_hole_r*2,0])
        cylinder(r=tie_hole_r, h=t*2, center=true);
    }
}

module bearing_holder_negative(
    od = drive_axle_bearing_od,
    t = drive_axle_bearing_od +bearing_pillow_rim_t*2,
    wall=bearing_pillow_side_t,
    //tie_hole_r = bearing_holder_tie_hole_r
) {
    //extra_length = wall*4 + tie_hole_r*4-.2;
    //tie_width = wall*2 + tie_hole_r*6-.2;
        union() {
            cylinder(r=od/2+wall-.2, h=t+wall*2, center=true);
          //  cube([od+extra_length,tie_width,t+wall*2], center=true);
        }
     
}
//bearing_holder_negative();

module bearing_holder_bottom(
    od = drive_axle_bearing_od,
    t = drive_axle_bearing_t,
    wall=bearing_holder_wall,
    cut = bearing_holder_cut
) {
    
    difference() {
        bearing_holder();
        translate([0,0,od*3/2-cut])
        cube([od*2,od*3,od*3], center=true);
        translate([0,0,-cut])
        bearing_holder_keyway();
    }
}
//bearing_holder_bottom();

module bearing_holder_top(
    od = drive_axle_bearing_od,
    t = drive_axle_bearing_t,
    wall=bearing_holder_wall,
    cut = bearing_holder_cut
) {
    
    difference() {
        bearing_holder(od=od, t=t, wall=wall, cut=cut);
        translate([0,0,-od*3/2-cut])
        cube([od*2,od*3,od*3], center=true);
    }
    translate([0,0,-cut])
    bearing_holder_key();
}
//rotate(180,[1,0,0])
//bearing_holder_top();

module bearing_holder_pair(
    od = drive_axle_bearing_od,
    t = drive_axle_bearing_t,
    wall=bearing_holder_wall
){
    translate([0,-od/2-wall-2,t/2+wall])
    rotate(180, [0,1,0])
    bearing_holder_top();
    translate([0,od/2+wall+2,t/2+wall])
    bearing_holder_bottom();
}
//bearing_holder_pair();

module bearing_holder_key(
    od = drive_axle_bearing_od,
    t = drive_axle_bearing_t,
    wall=bearing_holder_wall,
    tie_hole_r = bearing_holder_tie_hole_r
) {
    translate([od/2+wall+tie_hole_r,0,0])
    cube([tie_hole_r*2,tie_hole_r,tie_hole_r], center=true);
    translate([-od/2-wall-tie_hole_r,0,0])
    cube([tie_hole_r*2,tie_hole_r,tie_hole_r], center=true);
}
module bearing_holder_keyway(
    od = drive_axle_bearing_od,
    t = drive_axle_bearing_t,
    wall=bearing_holder_wall,
    tie_hole_r = bearing_holder_tie_hole_r,
    clearance = 1
) {
    translate([od/2+wall+tie_hole_r,0,0])
    cube([tie_hole_r*2+clearance,tie_hole_r+clearance,tie_hole_r+clearance], center=true);
    translate([-od/2-wall-tie_hole_r,0,0])
    cube([tie_hole_r*2+clearance,tie_hole_r+clearance,tie_hole_r+clearance], center=true);
}

module bearing_pillow() {

    difference() {
        union() {
            cylinder(r=drive_axle_bearing_od/2 + bearing_pillow_rim_t, h=drive_axle_bearing_t + bearing_pillow_side_t*2, center=true);
            cube([drive_axle_bearing_od+bearing_pillow_rim_t*2+bearing_pillow_screw_head_r*4+2,12,drive_axle_bearing_t + bearing_pillow_side_t*2], center=true);
        }
      cylinder(r=drive_axle_bearing_od/2 - 1, h=drive_axle_bearing_t*8, center=true);
      bearing();
        
      translate([drive_axle_bearing_od/2+bearing_pillow_rim_t+bearing_pillow_screw_head_r,0,0])
        rotate(90,[1,0,0]) 
            cylinder(r=bearing_pillow_screw_thread_r, h=50, center=true);
      translate([drive_axle_bearing_od/2+bearing_pillow_rim_t+bearing_pillow_screw_head_r,10,0])
        rotate(90,[1,0,0]) 
            cylinder(r=bearing_pillow_screw_shank_r, h=20, center=true);
      translate([drive_axle_bearing_od/2+bearing_pillow_rim_t+bearing_pillow_screw_head_r,15,0])
        rotate(90,[1,0,0]) 
            cylinder(r=bearing_pillow_screw_head_r, h=20, center=true);

      translate([-drive_axle_bearing_od/2-bearing_pillow_rim_t-bearing_pillow_screw_head_r,0,0])
        rotate(90,[1,0,0]) 
            cylinder(r=bearing_pillow_screw_thread_r, h=50, center=true);
      translate([-drive_axle_bearing_od/2-bearing_pillow_rim_t-bearing_pillow_screw_head_r,10,0])
        rotate(90,[1,0,0]) 
            cylinder(r=bearing_pillow_screw_shank_r, h=20, center=true);
      translate([-drive_axle_bearing_od/2-bearing_pillow_rim_t-bearing_pillow_screw_head_r,15,0])
        rotate(90,[1,0,0]) 
            cylinder(r=bearing_pillow_screw_head_r, h=20, center=true);
    }
}
module bearing_pillow_negative() {

    cylinder(r=drive_axle_bearing_od/2 + bearing_pillow_rim_t, h=drive_axle_bearing_t + bearing_pillow_side_t*2, center=true);
    cylinder(r=drive_axle_bearing_od/2 + bearing_pillow_rim_t-1, h=drive_axle_bearing_t *4, center=true);
    cube([drive_axle_bearing_od+bearing_pillow_rim_t*2+bearing_pillow_screw_head_r*4+2,12,drive_axle_bearing_t + bearing_pillow_side_t*2], center=true);

}
//%bearing_pillow();
//bearing_pillow_negative();
module bearing_pillow_top() {
   difference() {
        bearing_pillow();
        translate([0,-50,0])
            cube([100,100,100], center=true);
   } 
}
module bearing_pillow_bottom() {
   difference() {
        bearing_pillow();
        translate([0,50,0])
            cube([100,100,100], center=true);
   } 
}
//bearing_pillow_top();
//translate([0,-5,0])
//bearing_pillow_bottom();
//bearing_pillow();
//bearing_holder();
//bearing();