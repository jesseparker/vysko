//include <tracer.scad>
//include <tracer_bearing.scad>
include <bearing.scad>

$fn = 60;

frame_x = 60*2;
frame_y = frame_x;

frame_rod_r = 6.5/2;
frame_length = 500;

drive_axle_r = 8.5/2;
//inboard
//drive_position_x = frame_x/2 - drive_axle_bearing_od/2 - bearing_holder_wall - frame_rod_r;
//drive_position_y = frame_y/2 - drive_axle_bearing_od/2 - bearing_holder_wall - frame_rod_r;
//outboard
drive_position_x = frame_x/2+ drive_axle_bearing_od/2+bearing_pillow_rim_t;
drive_position_y = 0;
drive_axle_bearing_od = 22;

module frame_rod(r = frame_rod_r, h = frame_length) {
    cylinder(r =r, h = h, center=true);
}
module drive_axle(r = drive_axle_r, h = frame_length) {
    cylinder(r =r, h = h, center=true);
}
//frame_rod();


module frame_rods(x=frame_x, y = frame_y, r = frame_rod_r) {
    translate([x/2,y/2,0])
        frame_rod(r = r);
    translate([-x/2,y/2,0])
        frame_rod(r = r);
    translate([x/2,-y/2,0])
        frame_rod(r = r);
    translate([-x/2,-y/2,0])
        frame_rod(r = r);
    translate([drive_position_x,drive_position_y,0])
        drive_axle();
}

//frame_rods();

module rod_slots_2d(x=frame_x, y=frame_y) {
        translate([-x/2-frame_rod_r,-y/2-frame_rod_r*6])
            square(size = [frame_rod_r*2,frame_rod_r*6]);
        translate([x/2-frame_rod_r,-y/2-frame_rod_r*6])
            square(size = [frame_rod_r*2,frame_rod_r*6]);
        translate([-x/2-frame_rod_r,y/2])
            square(size = [frame_rod_r*2,frame_rod_r*6]);
        translate([x/2-frame_rod_r,y/2])
            square(size = [frame_rod_r*2,frame_rod_r*6]);    
}

module rod_slots_2d(x=frame_x, y=frame_y) {
        translate([-x/2-frame_rod_r,-y/2-frame_rod_r*6])
            square(size = [frame_rod_r*2,frame_rod_r*6]);
        translate([x/2-frame_rod_r,-y/2-frame_rod_r*6])
            square(size = [frame_rod_r*2,frame_rod_r*6]);
        translate([-x/2-frame_rod_r,y/2])
            square(size = [frame_rod_r*2,frame_rod_r*6]);
        translate([x/2-frame_rod_r,y/2])
            square(size = [frame_rod_r*2,frame_rod_r*6]);    
}

module rod_slots(h=10) {
    linear_extrude(height=h, center=true) rod_slots_2d();
}
//rod_slots();