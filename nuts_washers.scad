in = 25.4;

module washer_1_4() {
    translate([0,0,.065*in/2])
    difference() {
        cylinder(r = .734*in/2, h = .065*in, center=true);
        cylinder(r = 5/16*in/2, h = .2*in, center=true);
    }
}


//washer_1_4();

module washer_5_16() {
    translate([0,0,.083*in/2])
    difference() {
        cylinder(r = 7/8*in/2, h = .083*in, center=true);
        cylinder(r = 3/8*in/2, h = .2*in, center=true);
    }
}


//washer_5_16();

module nut_1_4() {
    translate([0,0,7/32*in/2])
    difference() {
        linear_extrude(height=7/32*in, center=true)
            circle(r=7/18*in/2, $fn = 6);
        cylinder(r=1/4*in/2, h= 1*in, center=true);
    }
}

//nut_1_4();

module nut_5_16() {
    translate([0,0,17/64*in/2])
    difference() {
        linear_extrude(height=17/64*in, center=true)
            circle(r=1/2*in/2, $fn = 6);
        cylinder(r=5/16*in/2, h= 1*in, center=true);
    }
}

//nut_5_16();

