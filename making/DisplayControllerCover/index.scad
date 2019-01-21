include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

thickness = 1.5;
rib_size = 2;
depth = 21 + rib_size;
height = 90;
$fn = 30;

module screw_hole() {
    rod(d=15, h=thickness+rib_size, anchor=[0,0,1]);
    rod(d=10, h=rib_size, anchor=[0,0,1], $class="hole");
    rod(d=3.3, h=10, anchor=[0,0,0], $class="hole");
}

module main() {
  differed("hole", "not(hole)") 
  box([150+thickness*2, height+thickness*2, thickness]) {
    // right
    align(x+y+z) color("lightblue") box([thickness, 40+thickness, depth], anchor=x+y+z);
    align(x-y+z) color("lightblue") box([thickness, 5, depth], anchor=x-y+z);

    // top
    align(x+y+z) color("lightgreen") box([35+thickness, thickness, depth], anchor=x+y+z);
    align(x+y-z) color("lightgreen") box([35+45+thickness, thickness, 5], anchor=x+y+z);
    align(-x+y+z) color("lightgreen") translated(x*16) box([58, thickness, depth], anchor=-x+y+z);
    align(-x+y+z) color("lightgreen") box([8, thickness, depth], anchor=-x+y+z);

    // left
    align(-x+y+z) color("lightblue") box([thickness, height+thickness, depth], anchor=-x+y+z);
    align(-x+y+z) translated(-40*y-(depth-8)*z) box([thickness,height-40, 8], anchor=-x+y+z, $class="hole");

    // bottom
    align(x-y+z) color("lightgreen") box([5, thickness, depth], anchor=x-y+z); 
    align(-x-y+z) color("lightgreen") box([30, thickness, depth], anchor=-x-y+z); 

    // rib
    align(y-z) translated(-y*30.5, n=[0:3]) box([150, thickness, rib_size], anchor=y+z);
    align(x-z) translated(-x*25.25, n=[0:6]) box([thickness, height, rib_size], anchor=x+z);

    // support
    // align(x+z) translated(-z*depth) box([thickness, height, 1], anchor=x-z);

    // screw holes
    align(-x+y+z) 
      translated(x*(34+thickness)-y*(6.5+56+thickness)) {
        children();
        translated(x*106) children();
      }
  }
}

// rotated(-x*90)
main() {
  screw_hole();
}