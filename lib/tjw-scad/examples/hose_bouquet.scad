/* Bouquet of long-stemmed hoses, to show off splines.
  Doesn't render with current versions of OpenSCAD, unfortunately.
*/

include <../dfm.scad>
include <../moves.scad>
use <../spline.scad>

path = [[-3, 0, 0], [5, 0, 0], [4, 2, 1], [-2, -1, 6], [-3, 3, 5], [4, 5, 12]];

for (a = [0 : 20 : 359])
  rotate([0, 0, a])
    translate([2, 0, 0])
      //spline_ramen(path, diameter=2, subdivisions=3, circle_steps=30);
      spline_udon(path, outer_diameter=2, subdivisions=3, circle_steps=12);
