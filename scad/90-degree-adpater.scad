use <SG-90.scad>
$fn = 32;

module cutOuts()
{
    translate([0, 0, 2.5])
    horn();
    translate([0, 0, 25])
    rotate([0, 90, 0])
    sg90();
    
    //screws
    translate([-7, -12, 0])
    cylinder(h=8, d=2.75);
    translate([+7, 22, 0])
    cylinder(h=8, d=2.75);
}

//bottom plate
difference()
{
    union()
    {
        translate([-10, -15, 0])
        cube([20, 40, 4]);
    }
    cutOuts();
}

//top plate
translate([25, 0, -4]) //move to side for printing
difference()
{
    union()
    {
        translate([-10, -15, 4])
        cube([20, 40, 4]);
        translate([-4, -15, 8])
        cube([4, 40, 25]);
    }
    cutOuts();
}