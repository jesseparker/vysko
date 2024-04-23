include <settings.scad>

use <strut_spinner.scad>

use <spinning_plate.scad>
    
use <spinner_bearing.scad>
use <driveshaft_pulley.scad>
use <sub_sidestrut.scad>

module sub_spinner() {

    translate([0,0,0])
        rotate(180,[0,1,0])
        spinner_bearing_assembly();
    
    translate([0,0,13])
        //rotate(180,[0,1,0])
        spinning_plate(show_spools=true);

    translate([0,0,13])
        spinner_insert(center_hole=2);
   
    translate([0,0,0]) 
        //rotate(180,[0,1,0])
        spinner_strut_part();


    translate([0,0,-strut_t/2])
        sub_sidestrut();

    translate([drive_position_x,drive_position_y,6])
        driveshaft_pulley();
   
}

sub_spinner();
