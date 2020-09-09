//
//$fn = 100;
$fn = 30;
smidge=.01;
///// You can change these values easily /////

frame_x =5*25.4;
frame_y = frame_x;
frame_rod_diameter=8;

bearing_diameter = 0.177*25.4; // .177 caliber BB
//bearing_diameter = 30; // marble

hole_diameter = 20; // Hollow center diameter

screw_diameter = 4;
screw_hole_diameter =  screw_diameter * 1.3;

number_of_screws = 4;
inner_number_of_screws = 6;


///// You can change these values with some thought /////

raceway_thickness = bearing_diameter * .8 ;

screw_inset = screw_hole_diameter /2;
//screw_inset=0;
raceway_inset = screw_inset;
//raceway_inset=0;



    bearing_race_diameter = 
    hole_diameter
    + screw_inset*4
    + screw_hole_diameter*2
    + raceway_inset*2
    + bearing_diameter
    ;

    raceway_diameter =
    bearing_race_diameter
    + bearing_diameter
    + raceway_inset*2
    ;

    inner_raceway_hole_diameter = 
    hole_diameter
    + screw_inset*4
    + screw_hole_diameter*2
    ;
    
    inner_raceway_diameter =
    bearing_race_diameter
    + bearing_diameter
    + raceway_inset*2
    + screw_inset*2
    + screw_hole_diameter*2
   ;

//spool
spool_d = 15; // main cylinder diameter
spool_h = 35; // main cylinder height
spool_hole = spool_d - 4; // hole diameter
spool_slope=1/6; // angle of conical section
spool_shaft_tol=2;

// rollers for winder 
center_pulley_r = 10;
center_pulley_t = 4;
center_pulley_angle = 45;
center_pulley_axle_r = 3;
center_pulley_axle_l = 22;
