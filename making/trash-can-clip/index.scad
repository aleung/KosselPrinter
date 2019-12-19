d = 6.4;
thickness = 1.5;

$fn=30;

module version1() {
  rotate_extrude(angle=210)
    translate([d/2, 0, 0])
      square([thickness, 5]);

  translate([d/2, -20, 0])
    cube([thickness, 20, 5]);
  translate([d/2+thickness/2, -20, 0]) cylinder(d=thickness, h=5);

  translate([-6.7, -3.8, 0]) rotate([0, 0, 30])
  rotate_extrude(angle=-70)
    translate([d/2, 0, 0])
      square([thickness, 5]);
  translate([-3.7, -6.25, 0]) cylinder(d=thickness, h=5);
}

module version2() {
  translate([d/2, -25, 0])
    cube([thickness, 25, 5]);
  translate([d/2+thickness/2, -25, 0]) cylinder(d=thickness, h=5);

  rotate_extrude(angle=200)
    translate([d/2, 0, 0])
      square([thickness, 5]);

  rotate([0, 0, 20])
    translate([-4.7, -16, 0])
      cube([thickness, 16, 5]);

  translate([-2.1, -17.3, 0]) rotate([0, 0, 20])
  rotate_extrude(angle=-90)
    translate([d/2, 0, 0])
      square([thickness, 5]);
  translate([-0.8, -21, 0]) cylinder(d=thickness, h=5);

}

version2();