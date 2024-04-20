$fn = 32;

// the motor will be this much wider horizontally, so that holes made by difference with it will have tolerance.
// this will also be added to the radius of the horns circles.
toleranceGap = 0.25; 

module sg90()
{
    union()
    {
         // Body
        translate([0, 5.5, -6.5])
        cube([12.5 + toleranceGap, 23 + toleranceGap, 24], true);
        // Collar
        translate([0, 5.5, 2.5/2])
        cube([12.5 + toleranceGap, 32.5 + toleranceGap, 2.5], true);
        // Raise
        translate([0, 0, 24-18.5])
        cylinder(h=4.5, d=11.5);
        
        // Screw holes

        translate([0, -11.5/2-3, -4.5])
        union()
        {
            cylinder(h=4.5, d=1.75);
            translate([0, 0, 2.25])
            cube([0.5, 2.5, 4.5], true);
        }
        translate([0, -11.5/2+26, -4.5])
        union()
        {
            cylinder(h=4.5, d=1.75);
            translate([0, 0, 2.25])
            cube([0.5, 2.5, 4.5], true);
        }
    }
}

module horn()
{
    // Bottom part
    translate([0, 0, -2.5])
    cylinder(h=4, d=7+toleranceGap);
    // Horn part
    hull()
    {
        translate([0, 14, 0])
        cylinder(h=1.5, d=4+toleranceGap);
        cylinder(h=1.5, d=5.5+toleranceGap);
    }
}

difference()
{
    cube([15, 65, 4]);
    translate([15/2, 15, 4])
    #sg90();
    translate([15/2, 45, 2.5])
    #horn();
}
