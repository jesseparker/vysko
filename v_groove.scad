$fa=2; $fs=.5;

module donut(
d=20,
r=1
) {
    rotate_extrude()
    translate([d/2,0])
    circle(r=r);
}
//donut();
//cylinder(r=10, h=.5, center=true);

module v_groove(
    d = 20,
    belt_d=2,
    angle=60,
    ){

        
        rotate_extrude()
        translate([d/2,0])
        union() {
            translate([-(belt_d/2)/cos(90-angle/2),0])
        polygon(points=[
            [0,0],
            [(belt_d*2)/tan(angle/2),belt_d*2],
            [(belt_d*2)/tan(angle/2),-belt_d*2],
        ]);
            color("black") circle(r=belt_d/2);
        }
}

//v_groove();