$fn=180;
difference() {
  cylinder(r=95);
  translate([0, 120]) cylinder(r=30);
  rotate([0,0,120]) translate([0, 120]) cylinder(r=38);
  rotate([0,0,-120]) translate([0, 120]) cylinder(r=38);
}
