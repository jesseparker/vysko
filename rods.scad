include <settings.scad>
include <jplib.scad>
//include <tracer.scad>
//include <tracer_bearing.scad>
include <bearing.scad>


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

module rod_slots_2d(x=frame_x, y=frame_y, spin = 45) {
    for (i = [0:3]) {
        rotate(i*90, z_axis)
        translate([x/2,y/2])
            rotate(spin,z_axis)
        translate([0,frame_rod_r*3])
                square(size = [frame_rod_r*2,frame_rod_r*6], center=true);
    }
}
//rod_slots_2d();
//frame_rods();
    
module rod_slots(h=10) {
    linear_extrude(height=h, center=true) rod_slots_2d();
}

module rod_slots_side_2d(x=frame_x, y=frame_y, spin = 30) {

    translate([x/2,y/2])
    rotate(spin,z_axis)
    translate([0,frame_rod_r*3])
    square(size = [frame_rod_r*2,frame_rod_r*6], center=true);
    
    translate([x/2,-y/2])
    rotate(spin,z_axis)
    translate([0,-frame_rod_r*3])
    square(size = [frame_rod_r*2,frame_rod_r*6], center=true);
}
module rod_slots_side(h=10, spin=90) {
    linear_extrude(height=h, center=true) rod_slots_side_2d(spin=spin);
}

//rod_slots_side();