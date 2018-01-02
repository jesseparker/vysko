drive_axle_r = 8.1/2;
drive_axle_bearing_id = 8;
drive_axle_bearing_od = 22.5;
drive_axle_bearing_t = 7;

bearing_holder_wall = 1.2;
bearing_holder_tie_hole_r = 3/2;
bearing_holder_cut = -1;

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
        cylinder(r=od/2-wall, h=t*2, center=true);
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
    t = drive_axle_bearing_t,
    wall=bearing_holder_wall,
    tie_hole_r = bearing_holder_tie_hole_r
) {
    extra_length = wall*4 + tie_hole_r*4-.2;
    tie_width = wall*2 + tie_hole_r*6-.2;
        union() {
            cylinder(r=od/2+wall-.2, h=t+wall*2, center=true);
            cube([od+extra_length,tie_width,t+wall*2], center=true);
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
        bearing_holder();
        translate([0,0,-od*3/2-cut])
        cube([od*2,od*3,od*3], center=true);
    }
    translate([0,0,-cut])
    bearing_holder_key();
}
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