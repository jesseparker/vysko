include <v_groove.scad>

module belt_pulley(
    d = 20,
    shaft_d=4,
    belt_d=2,
    angle=60,
    t=5.5,
    wedge_factor=.2
    ){
    difference() {
        
        union() {
    difference() {
        cylinder(r=d/2+belt_d,h=t, center=true);
        
        
        v_groove(
            d = d,
            belt_d=belt_d,
            angle=angle
        );
    }
        //cylinder(r=d/2-belt_d/2-belt_d*wedge_factor,h=t, center=true);
    }
        cylinder(r=shaft_d/2,h=t+1, center=true);

}
}

//belt_pulley();

module double_pulley(
    d1=15,
    d2=10,
    t=6,
    shaft_d=4,
    belt_d=2,
    angle=60
    ) {
    
    translate([0,0,t/2])
    belt_pulley(
        d=d1,
        t=t,
        shaft_d=shaft_d,
        belt_d=belt_d,
        angle=angle
    );
    translate([0,0,t+t/2])
    belt_pulley(
        d=d2,
        t=t,
        shaft_d=shaft_d,
        belt_d=belt_d,
        angle=angle
    );    

}



//belt_pulley();
//reducer_pulley(d1=10,d2=20);
//dia_1=80;

//double_pulley(d1=dia_1,d2=dia_1/4,belt_width=25.4/8,t=7);



//double_pulley(d1=15,d2=30,t=6);
//double_pulley(d1=20,d2=8);
