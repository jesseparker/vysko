include <settings.scad>
include <rods.scad>
include <bearing.scad>


module strut_2d(x=frame_x, y=frame_y, r = frame_rod_r, meat_factor=.4, ring_r = frame_x/2, do_bearing = 1, ring_translate = [0,0]) {
    
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
            if(do_bearing == 1) {
                //outboard bearing support
                translate([x/2,-(drive_axle_bearing_od+bearing_pillow_rim_t*2)/2])
                    square(size = [drive_axle_bearing_od/2+bearing_pillow_rim_t,drive_axle_bearing_od+bearing_pillow_rim_t*2]);
            }
        }
        translate(ring_translate)
        circle(r=ring_r-r*meat_factor);

        rod_slots_2d();
    }
}
//strut_2d(ring_r=10, ring_translate = [20,10]);

module strut(ring_r = 100, h =3, r = frame_rod_r+1, meat_factor=.6, do_bearing = 1) {
    difference() {
        linear_extrude(height=h)
            strut_2d(r = r, ring_r = ring_r, meat_factor = meat_factor, do_bearing=do_bearing);
        translate([0,0,-frame_length/2])
            frame_rods(r = frame_rod_r+1);
        //translate([frame_x/2/2,frame_y/2,drive_axle_bearing_t/2+1])
     //translate([drive_position_x,drive_position_y,0])
        //translate([0,0,drive_axle_bearing_t/2+bearing_holder_wall-1])
        //rotate(-45,[0,0,1])
        if (do_bearing == 0) {
        //bearing_holder_negative();
        translate([drive_position_x,drive_position_y,0])
            translate([0,0,drive_axle_bearing_t/2+bearing_pillow_side_t])
                rotate(-90,[0,0,1])
                    bearing_holder_negative();  
            
        }
    }
    // Inboard bearing holder
    //translate([drive_position_x,drive_position_y,0])
    //translate([0,0,drive_axle_bearing_t/2+bearing_holder_wall])
    //    rotate(-45,[0,0,1])
    //        bearing_holder_bottom();
    
            if (do_bearing == 1) {

    // Outboard bearing holder
    translate([drive_position_x,drive_position_y,0])
        translate([0,0,drive_axle_bearing_t/2+bearing_pillow_side_t])
            rotate(-90,[0,0,1])
                bearing_pillow_bottom();
    translate([frame_x/2+.1,0,0])
    //cube([10,10,10],center=true);
            rotate(180,[0,0,1])
            rotate(90,[1,0,0])
    linear_extrude(height=frame_rod_r/2, center=true)
    polygon([ [0,0], [0,drive_axle_bearing_t+bearing_pillow_side_t*2], [10,0]]);
            }
}
//strut(ring_r = 45);

module strut_diagonal(x=frame_x, y=frame_y, z=5, r = frame_rod_r, meat_factor=1, ring_r = 20, ring_translate = [0,0,0],do_bearing = 1) {
    difference() {
        hull() {             
            translate([x/2,y/2])
                cylinder(r=r+r*meat_factor, h=z, center=true);
            

            translate([-x/2,-y/2])
                cylinder(r=r+r*meat_factor, h=z, center=true);
            translate(ring_translate)
                cylinder(r=ring_r+r*meat_factor, h=z, center=true);
        }
        frame_rods();
        rod_slots();
    }
}
//strut_diagonal();

//strut_center_pulley();
//roller();

module strut_solid(x=frame_x, y=frame_y, z=5, r = frame_rod_r, meat_factor=1, ring_r = 20, ring_translate = [0,0,0],do_bearing = 1) {
    difference() {
        union() {
        hull() {             
            translate([x/2,y/2])
                cylinder(r=r+r*meat_factor, h=z, center=true);
            translate([-x/2,-y/2])
                cylinder(r=r+r*meat_factor, h=z, center=true);
            translate(ring_translate)
                cylinder(r=ring_r+r*meat_factor, h=z, center=true);
        }
        hull() {             
            translate([-x/2,y/2])
                cylinder(r=r+r*meat_factor, h=z, center=true);
            translate([x/2,-y/2])
                cylinder(r=r+r*meat_factor, h=z, center=true);
            translate(ring_translate)
                cylinder(r=ring_r+r*meat_factor, h=z, center=true);
        }
        cube([x*.9,y*.9,z],center=true);
    }
        
        frame_rods();
        rod_slots();
    
}    
}

module strut_mono(x=frame_x, y=frame_y, z=5, r = frame_rod_r*1.5, meat_factor=1, ring_r = 10, ring_translate = [45,45,0],do_bearing = 1) {
    difference() {
        union() {
        hull() {             
            translate([x/2,y/2])
                cylinder(r=r+r*meat_factor, h=z, center=true);
            translate(ring_translate)
                cylinder(r=ring_r+r*meat_factor, h=z, center=true);
        }
    }
        
        frame_rods();
    
        translate([x/2,y/2,0])
        rotate(55,[0,0,1])
        translate([0,10,0])
        cube([frame_rod_r*2,20,20], center=true);
        //rod_slots();
    
}    
}


