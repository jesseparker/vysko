x_axis = [1,0,0];
y_axis = [0,1,0];
z_axis = [0,0,1];

secondary_r = 4;
secondary_as_cube = false;

module tablet(v, center=true,r = secondary_r) {
    if (secondary_as_cube) {
        cube(v, center=center);
    }
    else {
        hull() {
            for (i = [1,-1]) {
                for (j = [1,-1]) {
                    translate([i*v[0]/2-i*r,j*v[1]/2-j*r,0])
                        cylinder(r=r, h=v[2], center=center);
                }        
            }
        }
    }
}

module stone(v, center=true,r = secondary_r) {
    if (secondary_as_cube) {
        cube(v, center=center);
    }
    else {
        hull() {
            for (i = [1,-1]) {
                for (j = [1,-1]) {
                    for (k = [1,-1]) {
                        translate([i*v[0]/2-i*r,j*v[1]/2-j*r,k*v[2]/2-k*r])
                            sphere(r=r, center=center);
                    }        
                }        
            }
        }
    }
}

module giftwrap(bounds = [1000,1000,1000], tail=[0,0,0]) {
    union() {
        intersection() {
            rotate(90 ,y_axis) linear_extrude(height=bounds[0], center=true) hull() projection() rotate(90 ,y_axis) children();
            rotate(90 ,x_axis) linear_extrude(height=bounds[1], center=true) hull() projection() rotate(90 ,x_axis) children();
            linear_extrude(height=bounds[2], center=true) hull() projection() children();
        }
        if (tail[0] != 0) {
            translate([tail[0]*bounds[0]/2,0,0]) rotate(90 ,y_axis) linear_extrude(height=bounds[0], center=true) hull() projection() rotate(90 ,y_axis) children();
        }
        if (tail[1] != 0) {
            translate([0,tail[1]*bounds[0]/2,0]) rotate(90 ,x_axis) linear_extrude(height=bounds[1], center=true) hull() projection() rotate(90 ,x_axis) children();
        }
    }
}

