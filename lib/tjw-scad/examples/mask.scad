/* Mask from last night's dream.
*/

include <../dfm.scad>
include <../moves.scad>
use <../spline.scad>

HEIGHT = 5;

difference() {
  // head
  cube([20, 60, HEIGHT], center=true);

  // eyes
  translate([0, 20, HEIGHT/2])
    for (i = [-1 : 2 : 2])
      spline_sausage([[i*6, 1, 0], [i*5, 0, 0], [i*4, 1, 0]], diameter=2);

  // nose
  translate([0, 0, HEIGHT/2])
    spline_sausage([[0, 10, 0], [-3, -5, 0], [0, -5, 0]], diameter=2);
}

// mouth
translate([0, -18, HEIGHT/2]) {
  spline_sausage([[-15, 0, 0], [0, 4, 0], [15, 0, 0]], diameter=2);
  spline_sausage([[-15, 0, 0], [0, -2, 0], [15, 0, 0]], diameter=2);
}
