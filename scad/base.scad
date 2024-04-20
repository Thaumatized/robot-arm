use <SG-90.scad>
$fn = 32;


module cutOuts()
{
    union()
    {
        translate([0, 0, 24])
        sg90();
    }
}

difference()
{
    union()
    {
        //center
        difference()
        {
            cylinder(h=24, d=50);
            cylinder(h=20, d=42);
            translate([0, 0, 10])
            rotate([90, 0, 0])
            #cylinder(h=50, d=10);
        }
        //cross
        translate([-5, -70, 0])
        cube([10, 140, 4]);
        translate([-70, -5, 0])
        cube([140, 10, 4]);
        //outer ring
        difference()
        {
            cylinder(h=4, d=150);
            cylinder(h=4, d=140);
        }
    }
    cutOuts();
}