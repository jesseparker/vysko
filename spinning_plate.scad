
module spinning_plate(
    num_spools=10,
    diameter=100,
    t=6,
    belt_diameter=3
) {
    angle=360/num_spools;

difference(){
union(){

cylinder(r=10,h=20);

cylinder(r=diameter/2,h=t);

for (i=[0:1:num_spools-1]){
rotate(angle*i, [0,0,1])
translate ([0,diameter/2-spool_d,3]) {

//spindles
cylinder(r=spool_hole/2*.8,h=spool_h*.6);
//%spool();


}



}



}
///TODO belt groove
rotate_extrude(convexity = 1)
translate([diameter/2, t/2, 0])
circle(r = belt_diameter/2, center=true);

screws();
translate([0,0,-1])
bearing_race();
cylinder(r=6,h=50,center=true);

}

}