include <settings.scad>
use <strut.scad>

module sub_sidestrut () {

    translate([0,0,-strut_t/2])
    strut_side();
    
    translate([drive_position_x,0,-drive_axle_bearing_t/2-bearing_pillow_side_t])
        rotate(-90,[0,0,1])  
            bearing_pillow_top();
            
 }
 
 sub_sidestrut();
 