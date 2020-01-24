// --- CONFIG
num_teeth = 2;
pillar_width = 39;
// --- END

width = pillar_width + 3*2;
length = 3 + (3+4.5) * (num_teeth-1);

difference() {
  union() {
    translate([0, 0, 3]) cube([length, width, 3]);
    translate([0, 0, 0]) cube([length, 3, 3]);
    translate([0, pillar_width+3, 0]) cube([length, 3, 3]);

    for (i = [1:num_teeth]) translate([7.5*(i-1), 0, 6]) teeth();
  }
  translate([3, 0, 0]) rut();
  translate([length-6, 0, 0]) rut();
  translate([3, width, 0]) rut();
  translate([length-6, width, 0]) rut();
}


module teeth() {
  translate([0, (width-9)/2, 0]) cube([3, 3, 5]);
  translate([0, (width-9)/2+6, 0]) cube([3, 3, 5]);
}

module rut() {
  translate([0, 0, 4]) rotate([45, 0, 0]) cube(3);
}
