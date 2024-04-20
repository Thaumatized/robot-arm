use <SG-90.scad>
$fn = 32;

armLength = 100;

module cutOuts()
{
    union()
    {
        translate([0, 0, 2.5])
        horn();
        translate([0, armLength, 6])
        rotate([0, 0, 180])
        sg90();
        //another motor to make sure both sides have screw holes.
        translate([0, armLength, 0])
        rotate([0, 180, 180])
        sg90();
        
        //screws
        translate([0, -7.5, 0])
        cylinder(h=6, d=2.75);
        translate([0, armLength+15, 0])
        cylinder(h=6, d=2.75);
    }
}

//bottom
difference()
{
    union() {
        translate([0, -7.5, 0])
        cylinder(h=3, d=15);
        translate([0, armLength+15, 0])
        cylinder(h=3, d=15);
        translate([-7.5, -7.5, 0])
        cube([15, armLength + 15 + 7.5, 3]);
    }
    cutOuts();
}

//top
translate([20, 0, +6]) // move to side for printing
rotate([0, 180, 0])
difference()
{
    translate([0, 0, 3])
    union() {
        translate([0, -7.5, 0])
        cylinder(h=3, d=15);
        translate([0, armLength+15, 0])
        cylinder(h=3, d=15);
        translate([-7.5, -7.5, 0])
        cube([15, armLength + 15 + 7.5, 3]);
    }
    cutOuts();
}