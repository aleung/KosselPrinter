include <../../lib/relativity.scad/relativity.scad>

floor_thickness = 1;
wall_thickness = 2;

thickness = 1.5;

fan_size = 120;
$fn = 30;
w1 = 45;
w2 = 30;
depth = fan_size + wall_thickness * 2;

intersection() {
  // box([200, 200, 100], anchor=-x);
  // box([200, 200, 100], anchor=x);

  hulled("hulled")
  box([fan_size, fan_size, 0]) {
    mirrored(x) mirrored(y) 
      align(-x-y) translated(14.7/2*x+14.7/2*y) rod(d=4, h=16, anchor=-z) align(-z) box([17, 14.7, 6], anchor=-z);
    align(-x-y-z) color("green") box([w1, wall_thickness, 6], anchor=x+y-z) {
      align(x-y+z) box([floor_thickness, depth, 12], anchor=x-y-z);
      align(-y+z) box([w1, depth, floor_thickness], anchor=-y-z);
      align(-x+y-z) translated(4.7*x+5*y) box([5, 5, 6], anchor=-z);
      align(-x-y+z) box([wall_thickness, 0.1, 24], anchor=-x-y-z, $class="hulled");
    }
    align(-x+y-z) color("blue") box([w1, wall_thickness, 18], anchor=x-y-z) {
      align(-x-y-z) translated(4.7*x-5*y) box([5, 5, 6], anchor=-z);
      align(-x+y+z) box([wall_thickness, 0.1, 12], anchor=-x+y+z, $class="hulled");
    }
    align(y-z) color("orange") box([fan_size, wall_thickness, 18], anchor=-y-z)
        align(x+y-z) differed("hole") box([10, 10, 6], anchor=x-y-z) box([5.6, 5.6, 7], $class="hole");
    align(x-y-z) color("lightgreen") box([w2, wall_thickness, 18], anchor=-x+y-z) {
      align(-y+z) box([$parent_size.x, depth, floor_thickness], anchor=-y+z) {
        align(x+y+z) box([floor_thickness, depth, 18], anchor=x+y+z);
        align(-x+y+z) box([floor_thickness, depth, 12], anchor=-x+y+z);
      }
      align(x-y-z) box([$parent_size.x, wall_thickness, 32], anchor=x-y-z);
    }
    mirrored(y) align(y-z) box([fan_size, 3, 2], anchor=y-z);
    align(-y-z) color("red") box([fan_size, wall_thickness, 32], anchor=y-z)
      translated(11*x) translated(23*x, n=[-3:3]) align(-y-z) box([4, 5, $parent_size.z], anchor=+y-z);
  }
}