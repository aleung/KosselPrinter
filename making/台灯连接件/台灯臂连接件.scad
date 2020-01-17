// Relativity SCAD library
// https://raw.githubusercontent.com/aleung/relativity.scad/master/relativity.scad
include <../../lib/relativity.scad/relativity.scad>

hole_d = 4.4;
column_d = 12;
rib_width = 3;
column_height = 2.5;
shell_thickness = 2.5;

offset_y = sqrt(pow(30,2)-pow(13.5,2));

$fn=36;

module column(height, d=column_d) {
  rod(d=d, h=height, anchor=z);
  rod(d=hole_d, h=40, anchor=center, $class="hole");
}

module skeleton(is_top) {
  differed("hole") {
    translated((is_top?1:-1)*21*x) rod(d=column_d, h=10-shell_thickness, anchor=-z);
    mirrored(x) 
      box([42, rib_width, column_height], anchor=z) 
        align(x+z) {
          column(column_height);
          rotated(205*z) box([20, rib_width, column_height], anchor=-x+z);
        }
    translated(-offset_y*y) mirrored(x)
      box([15, rib_width, column_height], anchor=z)
        align(x+z) {
          column(column_height);
          rotated(63*z) box([30, rib_width, column_height], anchor=-x+z);
          rotated(112*z) box([20, rib_width, column_height], anchor=-x+z);
      }
    translated(-offset_y/3*y) {
      column(column_height, d=14);
      if (is_top) {
        rod(d=8.7, h=10, anchor=-z, $class="hole");
      } else {
        rod(d=8.2, h=10, anchor=-z, $class="hole", $fn=6);
      }
    }
    hull() mirrored(x) {
      translated(21*x) rod(d=column_d, h=shell_thickness, anchor=-z);
      translated(7.5*x-offset_y*y) rod(d=column_d, h=shell_thickness, anchor=-z);
    }
  }
}


skeleton(true) ;
translated(50*y) skeleton(false) ;
