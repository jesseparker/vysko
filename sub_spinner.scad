include <settings.scad>

use <strut_spinner.scad>

use <spinning_plate.scad>
    
use <spinner_bearing.scad>
use <driveshaft_pulley.scad>


module sub_spinner() {

    translate([0,0,0])
        rotate(180,[0,1,0])
        spinner_bearing_assembly();
    
    translate([0,0,13])
        //rotate(180,[0,1,0])
        spinning_plate();
   
    translate([0,0,0]) 
        //rotate(180,[0,1,0])
        spinner_strut_part();


    translate([0,0,-strut_t])
        strut_side();
    
    translate([drive_position_x,0,-drive_axle_bearing_t/2-bearing_pillow_side_t-strut_t/2])
        rotate(-90,[0,0,1])  
            bearing_pillow_top();

    translate([drive_position_x,drive_position_y,6])
        driveshaft_pulley();
    
}

sub_spinner();
