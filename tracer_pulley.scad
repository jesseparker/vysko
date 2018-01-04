include <tracer_bearing.scad>
include <bearing.scad>
include <nuts_washers.scad>
include <rb-pulleys.scad>
include <rods.scad>

$fn = 30;
module tracer_double_pulley() {
    difference() {
        union() {
            belt_pulley(
                d = 20,
                shaft_d=drive_axle_r*2,
                belt_width=2,
                slope=.5,
                t= tracer_pulley_t
            );
            translate([0,0,tracer_pulley_t-.05])
            belt_pulley(
                d = 20,
                shaft_d=drive_axle_r*2,
                belt_width=2,
                slope=.5,
                t= tracer_pulley_t
            );
        }
        translate([0,0,-tracer_pulley_center_z])
            bearing_translate()
                drive_bearing_top_washer_translate()
                    drive_bearing_top_nut_translate()
                        nut_5_16();
    }
}

!rotate(180, [0,1,0]) tracer_double_pulley();

module drive_translate() {
    translate([0,60,0]) children();
}

module bearing_translate() {
    z = - drive_axle_bearing_t/2
        - bearing_holder_wall
        + journal_t/2;
    translate([0,0,z]) children();
}

module drive_bearing_top_washer_translate() {
    //z = drive_axle_bearing_t/2;
    z = 0;  
    translate([0,0,z]) children();
}

module drive_bearing_top_nut_translate() {
    z = washer_5_16_t;
    //z=0;
    translate([0,0,z]) children();
}

rotate(180,[0,1,0])
tracer_bearing_assembly();

drive_translate()
    bearing_translate()
        bearing_holder_top();

//drive_translate()
    //translate([0,0,-3.5])
    //bearing_holder_bottom();

drive_translate()
    bearing_translate()
        bearing();



//drive_translate()
//    bearing_translate()
//        drive_bearing_top_washer_translate()
//            washer_5_16();

drive_translate()
    bearing_translate()
        drive_bearing_top_washer_translate()
            drive_bearing_top_nut_translate()
                nut_5_16();




drive_translate()
//     bearing_translate()
///        drive_bearing_top_washer_translate()
 //           drive_bearing_top_nut_translate()
   translate([0,0,tracer_pulley_center_z])
        tracer_double_pulley();