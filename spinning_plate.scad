include <settings.scad>
include <jplib.scad>
include <spinner_bearing.scad>
use <spool.scad>
        insert_z = 5;
    i_tol=1;
    height = spool_h*.7;
    
module spinning_plate(
    num_spools=5,
    diameter=100,
    t=3,
    center_hole = 3,
    h=height,
    //ccw=1
    ccw=-1,
    show_spools = false
) {

    angle=360/num_spools;
    spool_radius = diameter/2-spool_d;
    // sin a = opp/hyp
    //
    half_spool_angle=ccw*asin((spool_d/2)/spool_radius);

    difference(){
        union(){

            cylinder(r=15,h=h-insert_z/2);

            cylinder(r=diameter/2,h=t);

            for (i=[0:1:num_spools-1]){
                rotate(angle*i, [0,0,1])
                translate ([0,spool_radius,3]) {
                    //spindles
                    cylinder(r=spool_hole/2*.8,h=spool_h*.6);
                    if (show_spools)
                        %spool();
                }
            }



        }



        //bore
        cylinder(r=8,h=h*2,center=true);
        insert_translate()
        //#cylinder(r=10,h=h*2,center=true);
        tablet([20+i_tol,20+i_tol,10], r=6);

        spinner_connect_holes();
    }

}

module insert_translate() {
    translate([0,0,height-insert_z])
        children();
}

module spinner_insert(
    num_spools=8,
    diameter=100,
    t=3,
    center_hole = 3,
    h=height,
    //ccw=1
    ccw=-1,
    show_spools = false
) {

    angle=360/num_spools;
    spool_radius = diameter/2-spool_d;
    // sin a = opp/hyp
    //
    half_spool_angle=ccw*asin((spool_d/2)/spool_radius);

    difference() {
        insert_translate()
            tablet([20,20,10]);
        
         for (i=[0:1:num_spools-1]){
            rotate(angle*i-half_spool_angle, [0,0,1])
            translate ([ccw*center_hole/2,diameter/8,h]) {
                //string channel
                cube([1.5,diameter/4,center_hole], center=true);
            }
        }
        //bore
        cylinder(r=center_hole/2,h=h*2,center=true);
        //chamfer
        translate([0,0,h-center_hole*2+.01])
        cylinder(r1=center_hole/2,r2=center_hole*2,h=center_hole*2);
       
    }
}

spinner_insert(center_hole=2);
//use <tracer_plate.scad>
//translate([0,0,100])
//rotate(180,[1,0,0]) tracer_plate();

//use <funnel.scad>
//translate([0,0,23])
//funnel();

//spinning_plate();

//translate([0,0,-40])
// "spinning_plate_ccw"
spinning_plate(num_spools=8, diameter=110, ccw=1, show_spools=true);
// "spinning_plate_cw"
//spinning_plate(num_spools=8, diameter=110, center_hole = 5,ccw=-1,ashow_spools=true);

//translate([0,0,-10])
//rotate(180,[1,0,0])
//tracer_inner_shell();