include <trapezoid_groove.scad>

module belt_pulley(
    d = 20,
    shaft_d=4,
    belt_width=2,
    slope=.5,
    t=5
    ){
    
    difference() {
        cylinder(r=d/2+belt_width,h=t, center=true);
        
        cylinder(r=shaft_d/2,h=belt_width*5, center=true);
        
        trapezoid_groove(
            d = d,
            belt_width=belt_width,
            slope=slope
        );
    }
}

module double_pulley(
    d1=15,
    d2=10,
    t=5,
    shaft_d=4,
    belt_width=2,
    slope=.5,
    ) {
    
    translate([0,0,t/2])
    belt_pulley(
        d=d1,
        t=t,
        shaft_d=shaft_d,
        belt_width=belt_width,
        slope=slope
    );
    translate([0,0,t+t/2])
    belt_pulley(
        d=d2,
        t=t,
        shaft_d=shaft_d,
        belt_width=belt_width,
        slope=slope
    );    

}



//belt_pulley();
//reducer_pulley(d1=10,d2=20);
//dia_1=30;

//double_pulley(d1=dia_1,d2=dia_1/4,belt_width=25.4/8,t=7);



//double_pulley(d1=7,d2=15,t=2);
//double_pulley(d1=20,d2=8);
