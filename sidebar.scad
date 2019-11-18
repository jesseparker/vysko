include <rods.scad>
include <bearing.scad>

//frame_rods();
pull_axle_offset = frame_x/4;
pull_axle_z = 10;

sidebar_tab_t = 4;
sidebar_w = drive_axle_bearing_t+bearing_pillow_side_t*2;

//translate([0,frame_y/2,0]) 
union() {
    difference() {
        union() {
            translate([0,0,sidebar_tab_t/2])
        cube([frame_x+frame_rod_r*4,sidebar_w,sidebar_tab_t],center=true);
            translate([0,0,sidebar_tab_t-1])
            rotate(90,[1,0,0])
linear_extrude(height=sidebar_w, center=true)
polygon([
    [-frame_x/2 + frame_rod_r*2 , 0],
    [frame_x/2 - frame_rod_r*2 , 0],
    [pull_axle_offset+drive_axle_bearing_od/2+bearing_pillow_rim_t+bearing_pillow_screw_head_r*2,pull_axle_z+1],
    [pull_axle_offset-drive_axle_bearing_od/2-bearing_pillow_rim_t-bearing_pillow_screw_head_r*2,pull_axle_z+1],
]);
        }
        translate([pull_axle_offset,0,pull_axle_z+sidebar_tab_t]) 
            rotate(90,[1,0,0])
                bearing_pillow_negative();
        //rod slots
        translate([frame_x/2+frame_rod_r*2,0,0])
            cube([frame_rod_r*4,frame_rod_r*2,20],center=true);
        translate([-frame_x/2-frame_rod_r*2,0,0])
            cube([frame_rod_r*4,frame_rod_r*2,20],center=true);
translate([0,frame_y/2,-20]) 
            frame_rods();
    }
    translate([pull_axle_offset,0,pull_axle_z+sidebar_tab_t]) 
    rotate(90,[1,0,0])
        bearing_pillow_top();
    translate([pull_axle_offset,0,pull_axle_z+sidebar_tab_t]) 
   rotate(90,[1,0,0])
        bearing_pillow_bottom();
}