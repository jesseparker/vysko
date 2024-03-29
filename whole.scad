use <rods.scad>

frame_rods();

use <sub_tracer.scad>


translate([0,0,150])
    sub_tracer();

use <sub_funnel.scad>       

translate([0,0,120])

sub_funnel();

use <sub_spinner.scad>

translate([0,0,10])
    sub_spinner();

translate([0,0,-100])
    sub_spinner();
    
        
 use <sub_winder.scad>
 
 translate([0,0,-150])
    winder_assembly();
 