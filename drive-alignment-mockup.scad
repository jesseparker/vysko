include <tracer_bearing.scad>
include <bearing.scad>
include <nuts_washers.scad>
include <rb-pulleys.scad>

module drive_translate() {
    translate([0,60,0]) children();
}

drive_translate()
    translate([0,0,1])
    washer_1_4();

drive_translate()
    translate([0,0,1])
    nut_1_4();

drive_translate()
    translate([0,0,-3.5])
    bearing();

drive_translate()
    translate([0,0,-3.5])
    bearing_holder_top();

rotate(180,[0,1,0])
tracer_bearing_assembly();

drive_translate()
    translate([0,0,6])
    belt_pulley(
        d = 20,
        shaft_d=8,
        belt_width=2,
        slope=.5,
        t= tracer_pulley_t
    );