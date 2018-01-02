include <rods.scad>
include <bearing.scad>

module strut_2d(x=frame_x, y=frame_y, r = frame_rod_r, meat_factor=.4, ring_r = frame_x/2) {
    
    difference() {
        union() {
                
            translate([x/2,y/2])
                circle(r=r+r*meat_factor);
            translate([-x/2,y/2])
                circle(r=r+r*meat_factor);
            translate([x/2,-y/2])
                circle(r=r+r*meat_factor);
            translate([-x/2,-y/2])
                circle(r=r+r*meat_factor);
            translate([-x/2-r*meat_factor/2,-y/2])
                square(size = [r*meat_factor,y]);
            translate([x/2-r*meat_factor/2,-y/2])
                square(size = [r*meat_factor,y]);
            translate([-x/2,-y/2-r*meat_factor/2])
                square(size = [x,r*meat_factor]);
            translate([-x/2,y/2-r*meat_factor/2])
                square(size = [x,r*meat_factor]);
            rotate(45, [0,0,1])
                translate([-sqrt(x*x+y*y)/2,-r*meat_factor/2])
                    square(size = [sqrt(x*x+y*y),r*meat_factor]);
            rotate(-45, [0,0,1])
                translate([-sqrt(x*x+y*y)/2,-r*meat_factor/2])
                    square(size = [sqrt(x*x+y*y),r*meat_factor]);
            rotate(0, [0,0,1])
                translate([-x/2,-r*meat_factor/2])
                    square(size = [x,r*meat_factor]);
            rotate(90, [0,0,1])
                translate([-y/2,-r*meat_factor/2])
                    square(size = [y,r*meat_factor]);
            circle(r=ring_r);
        }
        circle(r=ring_r-r*meat_factor);
    }
}

module strut(ring_r = 100, h =2, r = frame_rod_r+1, meat_factor=.4) {
    difference() {
        linear_extrude(height=h) strut_2d(r = r, ring_r = ring_r, meat_factor = meat_factor);
        translate([0,0,-frame_length/2])
        frame_rods(r = frame_rod_r+1);
        //translate([frame_x/2/2,frame_y/2,drive_axle_bearing_t/2+1])
     translate([drive_position_x,drive_position_y,0])
        translate([0,0,drive_axle_bearing_t/2+bearing_holder_wall-1])
        rotate(-45,[0,0,1])
        bearing_holder_negative();
        
    }
    translate([drive_position_x,drive_position_y,0])
    translate([0,0,drive_axle_bearing_t/2+bearing_holder_wall])
        rotate(-45,[0,0,1])
            bearing_holder_bottom();
}

//strut(ring_r = 35);