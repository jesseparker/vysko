include <settings.scad>
include <rb-pulleys.scad>

module roller(r=center_pulley_r, t=center_pulley_t, angle=center_pulley_angle, tol=0, neg=false) {
    if(neg) {
        cylinder(r=r+t+tol/2, h=t+tol, center=true);
    }
    else {
        belt_pulley(
            d = center_pulley_r*2,
            shaft_d=4,
            belt_width=2,
            slope=.5,
            t=center_pulley_t
        );
    }
    cylinder(r=center_pulley_axle_r+tol/2, h= center_pulley_axle_l, center=true);
}

//roller();