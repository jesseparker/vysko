use <rods.scad>

color("gray")
frame_rods();

use <sub_tracer.scad>

color("PeachPuff")
translate([0,0,150])
    sub_tracer();

use <sub_funnel.scad>       

color("Peru")
translate([0,0,120])
    sub_funnel();

use <sub_spinner.scad>

color("GreenYellow")
translate([0,0,10])
    sub_spinner();

color("Salmon")
translate([0,0,-100])
    sub_spinner();
    
        
 use <sub_winder.scad>
 
 color("CornflowerBlue")
 translate([0,0,-130])
    winder_assembly();
 