include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

width = 50;
depth = 17;
height = 15;
thickness = 2;
$fn = 30;

box([10, 6.7, 8.7])
align(x+z)
box([2, depth, height], anchor=z) 
differed("hole", "not(hole)") {
  align(x+y-z) box([width, thickness, 8], anchor=-x+y-z);
  align(x-z) box([width, depth, thickness], anchor=-x-z)
  align(-x-y) translated(-x*6) translated(x*23, n=[1,2])
    class("hole") {
      translated(y*4) rod(d=8.5, anchor=-y);
      hulled() {
        box([8.5, 8, 3], anchor=-y);
        box([8.5, 1, 3], anchor=y);
      }
      translated(y*1.5) box([12, 5, 3], anchor=-y);
    }
}
