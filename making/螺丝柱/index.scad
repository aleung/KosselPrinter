include <../../lib/relativity.scad/relativity.scad>

height = 11;
diameter = 10;
hole_diameter = 4;

$fn=36;

module A() {
  differed("hole", "not(hole)")
  rod(d=diameter, h=height)
  rod(d=hole_diameter, h=$parent_size.z + 0.01, $class="hole");
}


module B() {
  rod(d=diameter, h=height)
  align(top)
  rod(d=hole_diameter, h=5);
}

B();
