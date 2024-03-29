include <settings.scad>
include <jplib.scad>
include <strut.scad>
include <roller.scad>
include <bearing.scad>
include <nuts_washers.scad>
include <v_pulleys.scad>

drum_x=-25;
drum_y=drum_x;
drum_r=15;
//drum_r=20;
drum_d=drum_r*2;
drum_h=60;
drum_axle_r=1.3;
drum_axle_h=110;
drum_spacer_h=12;
drum_pulley_d = 45;
winder_drive_pulley_d = 20;

winder_floor_z = -95;
winder_ceiling_z =  0;
reducer_d1 = 60;
reducer_d2 = 17;
reducer_x = 0;
reducer_y = 35;
reducer2_x = 35;
reducer2_y = -25;

// TODO  Should the drum should move outward further?

side_pulley_setback = 37;
pulley_c_pulldown = 4;


// Ratio driveshaft turns : drum turns
ratio = 1 / ( (winder_drive_pulley_d/reducer_d1)*(reducer_d2/reducer_d1)*(reducer_d2/drum_pulley_d)*(drum_d/drum_pulley_d) );


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
            strut_diagonal(meat_factor = 1.5, ring_r=10);
           // cylinder(r=roller_r*2+roller_t
            translate([0,0,center_pulley_r])
                roller_post(h=5);
            translate([drum_x,drum_y,drum_spacer_h/2+strut_t/2-smidge])
            cylinder(r=4, h=drum_spacer_h, center=true);
            
          //  translate([side_pulley_setback,side_pulley_setback,center_pulley_r])
           //     roller_post(h=1);
        }

        union() {
            center_pulley_roller_translate_a()
            roller(tol=1.5, neg=true);
            //roller_post(tol=0);
           // center_pulley_roller_translate_b()
          //  roller(tol=1, neg=true);

        }
        //bore
        cylinder(r=5.5,h=40, center=true);
        drum_axle(neg=true, tol=.6);

    }
    //translate([0,0,center_pulley_r])
    //    roller();
    //translate([35,35,center_pulley_r])
    //    roller();
    //bore

}
//!strut_center_pulley();

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
                    cylinder(r=center_pulley_axle_r*3, h=t*5,center=true);
                    translate([0,-center_pulley_axle_r*3-h+.5,0])
                        cube([center_pulley_axle_r*6,1,t*5], center=true);
                }
        }
   }
   //roller(tol=1);
   }
}

module drum_translate() {
    translate([drum_x,drum_y,-drum_h/2-winder_floor_z-strut_t/2-drum_spacer_h])
        children();
}
module drum_axle(tol=0, neg=false) {
    drum_translate()
    cylinder(r=drum_axle_r+tol/2,h=drum_axle_h,center=true);
    if(neg) {
        drum_translate()
        translate([0,-20,0])
        cube([drum_axle_r*2+tol,40,drum_axle_h], center=true);
    }
}

module drum(neg=false) {

    difference() {
       drum_translate()
       union() {
            cylinder(r1=drum_r*.97,r2=drum_r,h=drum_h,center=true);
            translate([0,0,drum_h/2-2.5])
                belt_pulley(d=drum_pulley_d, angle=70);
        }
        drum_axle(tol=.5);
        // for tying onto
        drum_translate()
        translate([0,drum_r/2,-2.5])
        rotate(45,x_axis)
        cube([drum_r*2+1,drum_r*.4,drum_r*.4], center=true);
    }
    
}

module strut_drum() {
    difference() {
        union() {
            rotate(180,[1,0,0])
            strut_solid(meat_factor=2,z=strut_t+2);
            translate([drum_x,drum_y,-drum_spacer_h/2-strut_t/2+smidge])
            cylinder(r=4, h=drum_spacer_h, center=true);
        }
        translate([0,0,-drum_axle_h/2])
        drum_axle(neg=true, tol=.6);
        
        translate([0,0,winder_floor_z])
        reducer_translate()
        reducer_bolt(tol=1);
        translate([0,0,winder_floor_z])
        reducer2_translate()
        reducer_bolt(tol=1);    }
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

module reducer_bolt(tol=0) {
    
    translate([0,0,-.1]) {
        bolt_1_4_x_1_5(tol=tol);

        rotate(180,x_axis)
            nut_1_4();
    }
}


module reducer_translate() {
    translate([reducer_x,reducer_y,-winder_floor_z-strut_t/2-6.5])
    children();
}
module reducer2_translate() {
    translate([reducer2_x,reducer2_y,-winder_floor_z-strut_t/2-6.5])
    children();
}
module reducer2_translate() {
    translate([reducer2_x,reducer2_y,-winder_floor_z-strut_t/2-6.5])
    children();
}

module reducer() {
    double_pulley(d1=reducer_d1, d2=reducer_d2, shaft_d=7, angle=70);
}




module winder_assembly() {
    //frame_rods();
    
    translate([0,0,winder_ceiling_z]) {
        rotate(180,[1,0,0])
            strut_center_pulley();
        rotate(180,[1,0,0])
        center_pulley_roller_translate_a()
            roller(tol=1);
       // center_pulley_roller_translate_b()
       //     roller();
    }
 
     translate([0,0,winder_floor_z/2+10]) {
        rotate(180,[1,0,0])
            strut_roller_c();
        rotate(180,[1,0,0])
            center_pulley_roller_translate_c()
                roller();
    }
    
    translate([0,0,winder_floor_z])
    rotate(180,[1,0,0])
        strut_drum();
    // reducer
    rotate(180,[1,0,0])
        reducer_translate()
    rotate(180,[1,0,0])
    {
        reducer();
    
        reducer_bolt();
    }
    
    rotate(180,[1,0,0])
    reducer2_translate()
    rotate(180,[1,0,0])
    {
        translate([0,0,10])
        rotate(180,x_axis)
        reducer();
    
        reducer_bolt();
    }

    rotate(180,[1,0,0])
        drum();
    rotate(180,[1,0,0])
    drum_axle();
   
       rotate(180,[1,0,0])
        translate([drive_position_x,drive_position_y,-winder_floor_z-12])
    belt_pulley();

    translate([0,0,winder_floor_z-strut_t])
    strut_side();
}

winder_assembly();




module to_print() {
    //rotate(180,x_axis)
    //    strut_drum();
    
     //strut_roller_c();
    
    //strut_center_pulley();

    //rotate(180,x_axis)
    //drum();
    
    reducer();
    
    //strut_center_pulley();

    //rotate(180,x_axis)
    //    drum();
    //roller();
}
//to_print();

echo("Drum ratio: ", ratio, ":1");