in = 25.4;

washer_1_4_t = .06*in;
washer_5_16_t = .083*in;

module washer_1_4() {
    washer(
        t= washer_1_4_t,
        od= .57*in,
        id = .26*in
    );
}
module washer_1_4() {
    translate([0,0,.060*in/2])
    difference() {
        cylinder(r = .57*in/2, h = .060*in, center=true);
        cylinder(r = .26*in/2, h = .2*in, center=true);
    }
}


//washer_1_4();

module washer_5_16() {
    washer(
        t= washer_5_16_t,
        od= 7/8*in,
        id = 3/8*in
    );
}

module washer(t=1, od=10, id=6) {
    translate([0,0,t/2])
    difference() {
        cylinder(r = od/2, h = t, center=true);
        cylinder(r = id/2, h = t+1, center=true);
    }
}

//washer_5_16();

module nut_1_4() {
    nut(
        h= .22 * in,
        od= .50 * in,
        id= .20 * in
    );
}


//nut_1_4();

module nut_5_16() {
    nut(
        h= .27 * in,
        od= .59 * in,
        id= .27 * in
    );
}

module nut(h=10, od = 14, id = 6) {
    translate([0,0,h/2])
    difference() {
        linear_extrude(height=h, center=true)
            circle(r=od/2, $fn = 6);
        cylinder(r=id/2, h=h+1, center=true);
    }    
}
//nut();
//nut_5_16();

