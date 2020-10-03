include <settings.scad>
include <v_pulleys.scad>
include <nuts_washers.scad>

module driveshaft_pulley(d=20) {
    difference() {
        union() {
            belt_pulley(
                d = d,
                shaft_d=drive_axle_r*2,
                belt_width=3,
                t = 6,
                wedge_factor=.5
            );
        }
        translate([0,0,1.3])
            nut_5_16();
    }
}

//driveshaft_pulley(d=18);
