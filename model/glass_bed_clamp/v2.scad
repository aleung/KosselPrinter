include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

// -----------------------
// configuration
plate_diameter = 200;
plate_thickness = 3 - 0.5;  // set it to a little smaller then real thickness
lip_thickness = 2;
lip_size = 3;
y_offset = 5;
debug = false;
// -----------------------

width = 12;
$fn = 120;

height = plate_thickness + lip_thickness;
plate_radius = plate_diameter / 2;
x_offset = sqrt(pow(plate_radius, 2) - pow(plate_radius - y_offset - 5, 2));

module plate() {
  rod(d=plate_diameter, h=plate_thickness, anchor=-y-z);
}

module main() {
  difference() {
    union() {
      translated(x_offset*x + (y_offset-8)*y) box([width, x_offset, height], anchor=-y-z);
      translated(x_offset*x + y_offset*y) box([width, 6, 1], anchor=top);
    }
    translated(plate_radius*y) rod(r=plate_radius-lip_size, h=height+1, anchor=-z);
    translated(x_offset*x+y_offset*y) rod(d=3.1, h=height*2);
    translated(x_offset*x+y_offset*y+2*z) rod(d=6.1, h=height+1, anchor=-z);
    translated(x_offset*x+y_offset*y) box([7, 7, 1.01], anchor=top);
    plate();
  }
}

if (debug) {
  main();
  color("red") plate();
} else {
  rotated(90*y) main();
}
