include <../../lib/relativity.scad/relativity.scad>

floor_thickness = 1;
wall_thickness = 2;

differed("hole")
box([105, 120, floor_thickness]) {
  translated(35*x, n=[-3:0]) align(x) box([25, 100, floor_thickness*2], anchor=x, $class="hole");
  align(-y-z) color("red") box([$parent_size.x, wall_thickness, 32], anchor=y-z) {
    mirrored(x) align(x+y-z) box([wall_thickness, 10, $parent_size.z-4], anchor=x-y-z);
    translated(25.2*x, n=[0:4]) align(-x-y-z) box([4, 5, $parent_size.z], anchor=-x+y-z);
  }
  align(y-z) color("orange") box([$parent_size.x, wall_thickness, 18], anchor=-y-z) {
    mirrored(x) align(x-y-z) box([wall_thickness, 10, $parent_size.z], anchor=x+y-z);
    translated(30*x) align(-x+y-z) box([10, 10, 6], anchor=-x-y-z) box([5.6, 5.6, 7], $class="hole");
  }
  align(-x-z) box([wall_thickness, $parent_size.y, 10], anchor=-x-z);
  mirrored(y) align(x-y-z) box([10, 10, 6], anchor=-x-y-z) box([5.6, 5.6, 7], $class="hole");
};

