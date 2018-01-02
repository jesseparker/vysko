
module trapezoid_groove(
    d = 20,
    belt_width=2,
    slope=.5,
    ){
        inside_corner=belt_width/2;
        outside_corner_x=
            inside_corner
            +belt_width*4;
        outside_corner_y=
            inside_corner 
            + outside_corner_x*slope;
        
        rotate_extrude()
        translate([d/2,0,0])
        polygon(points=[
            [0,-inside_corner],[0,inside_corner],
            [outside_corner_x,outside_corner_y],
            [outside_corner_x,-outside_corner_y],
        ]);
}