//
//$fn = 100;
//$fn = 30;
smidge=.01;

lhf = .35;  // Layer Height FFFFirst
lh = .3; // Layer Height

// in this model there are "z axis" tolerances that are 
// in the range of a 3d printer layer height.  Some dimensions 
// need to be modelled as actual printed heights.  Adjust lhf and lh
// (above) for your slicer settings.
// layer_multiple() returns the closest layer height >= a distance
function layer_multiple(z) = (z <= lhf) ? lhf : lhf+lh*(ceil((z-lhf)/lh));
//foo = layer_multiple(100);
//echo(foo);

frame_x = 120;
frame_y = frame_x;
frame_rod_diameter=8;

frame_rod_r = 6.5/2;
frame_length = 500;


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

drive_position_x = frame_x/2+ 25;
drive_position_y = 0;

strut_t = layer_multiple(4);

//spool
spool_d = 15;
spool_h = 35;
spool_flange_ratio=.8;
spool_hole = spool_d - 4; // hole diameter
spool_slope=1/6; // angle of conical section
spool_shaft_tol=2;

// rollers for winder 
center_pulley_r = 10;
center_pulley_t = 5;
center_pulley_angle = 45;
center_pulley_axle_r = 1.5;
center_pulley_axle_l = 30;

spinner_center_hole_r = 25;
tracer_center_hole_r = 55;

funnel_h = 70;
funnel_r = 50;
funnel_wall = 2.5;
funnel_flange = 3;
funnel_flange_t = 1;
