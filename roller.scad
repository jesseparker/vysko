include <settings.scad>
include <rb-pulleys.scad>

module roller(r=center_pulley_r, t=center_pulley_t, angle=center_pulley_angle, tol=0, neg=false) {

    if(neg) {
        cylinder(r=r+t+tol/2, h=t+tol, center=true);
    cylinder(r=center_pulley_axle_r+tol/2, h= center_pulley_axle_l, center=true);
    }
    else {
            difference() {
        belt_pulley(
            d = center_pulley_r*2,
            shaft_d=center_pulley_axle_r+tol/2,
            belt_d=2,
            t=t
        );
                    cylinder(r=center_pulley_axle_r+tol/2, h= center_pulley_axle_l, center=true);

    }
}
}
//roller();
//%roller(neg=true, tol=1);