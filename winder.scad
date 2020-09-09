include <settings.scad>
include <strut.scad>
include <roller.scad>

side_pulley_setback = 37;
pulley_c_pulldown = 4;

module center_pulley_roller_translate_a(angle=center_pulley_angle,r=center_pulley_r) {
    translate([0,0,r])
    rotate(angle,[0,0,1])
    translate([r,0,0])
    rotate(90,[1,0,0])
    children();
}

module center_pulley_roller_translate_b(angle=center_pulley_angle,r=center_pulley_r) {
    translate([side_pulley_setback,side_pulley_setback,0])
    center_pulley_roller_translate_a()
    children();
}

module center_pulley_roller_translate_c(angle=center_pulley_angle,r=center_pulley_r) {
       translate([0,0,-pulley_c_pulldown])
        center_pulley_roller_translate_b()
    children();
}

module strut_center_pulley(roller_r = center_pulley_r, roller_t=center_pulley_t, angle=center_pulley_angle) {
    
    difference() {
        union() {
            %strut_diagonal(ring_translate = [roller_r/2,roller_r/2,0]);
           // cylinder(r=roller_r*2+roller_t
            translate([0,0,center_pulley_r])
                roller_post(h=1);
            
            translate([side_pulley_setback,side_pulley_setback,center_pulley_r])
                roller_post(h=1);
        }

        union() {
            center_pulley_roller_translate_a()
            roller(tol=1, neg=true);
            //roller_post(tol=0);
            center_pulley_roller_translate_b()
            roller(tol=1, neg=true);

        }
        //bore
        cylinder(r=5.5,h=40, center=true);
    }
    //translate([0,0,center_pulley_r])
    //    roller();
    //translate([35,35,center_pulley_r])
    //    roller();
    //bore

}

module roller_post(r=center_pulley_r, t=center_pulley_t, h=0, angle=center_pulley_angle ) {
     difference() {
         rotate(angle,[0,0,1])
    translate([r,0,0])
    rotate(90,[1,0,0])

    union() {
  //      cylinder(r=r,h=t,center=true);
  //      cylinder(r=3.1,h=t*6,center=true);
        hull() {
            translate([0,0,0])
                union() {
                    cylinder(r=center_pulley_axle_r*2.5, h=t*5,center=true);
                    translate([0,-center_pulley_axle_r*2.5-h+.5,0])
                        cube([center_pulley_axle_r*5,1,t*5], center=true);
                }
        }
   }
   //roller(tol=1);
   }
}
module drum() {
    translate([-25,-25,-50])
    union() {
    cylinder(r=20,h=80,center=true);
    cylinder(r=3,h=120,center=true);
        translate([0,0,40])
        belt_pulley(d=40);
    }
}

module strut_drum() {
    strut_solid();
}

module strut_roller_c() {
    pulldown = 4;
    difference() {
        union() {
   strut_mono();
            
    translate([side_pulley_setback,side_pulley_setback,center_pulley_r-pulley_c_pulldown])
    //rotate(180,[1,1,0])
    roller_post();
        }
        center_pulley_roller_translate_c()
        roller(tol=1, neg=true); 
    }
}


module winder_assembly() {
    frame_rods();
    
    strut_center_pulley();
    center_pulley_roller_translate_a()
        roller();
    center_pulley_roller_translate_b()
        roller();
    
    translate([0,0,100])
    strut_drum();
 
    translate([-10,30,100-5])
    rotate(180,[1,0,0])
    double_pulley(d1=50, d2=20);
    
    translate([0,0,100])
    drum();
    
        translate([drive_position_x,drive_position_y,95])
    roller();

    translate([0,0,50]) {
    strut_roller_c();
    center_pulley_roller_translate_c()
    roller();
    }
}

winder_assembly();