include <../../lib/relativity.scad/relativity.scad>

length = 90;
$fn=36;

module A() {
  differed("hole", "not(hole)") {
    box([42, 10, 1.5], anchor=bottom);
    box([42, 4, 2], anchor=bottom, $class="hole");
  }
  translated(25*x, n=[-1,1]) differed("hole", "not(hole)") {
    box([8, 10, 1.5], anchor=bottom)
      align(-z) box([$parent_size.x, 4, 4], anchor=-z);
    rod(d=3.3, h=10, anchor=bottom, $class="hole");
  }  
  box([6, 4, 4], anchor=bottom);
}

module B() {
  mirrored(x)
    box([69, 4, 2], anchor=bottom)
    align(x-y) box([5, 8, $parent_size.z], anchor=x+y)
    translated(-9*x) align(-x) box([5, $parent_size.y, $parent_size.z], anchor=x);
  box([41, 2, 4], anchor=bottom);
}

module C(bucket_position) {
  differed("hole", "not(hole)")
  box([4, length, 8]) {
    align(x-y) translated(bucket_position*y) color("blue") box([9, 4, $parent_size.z], anchor=-x-y)
      align(x-y) box([3, 10, $parent_size.z], anchor=x+y);
    align(-x-y) color("red") box([20, 6, $parent_size.z], anchor=-x+y);
    align(x-y) rotated(45*z) box([4.5, 4.5, $parent_size.z], anchor=center);
    hulled("not(hole)")
      align(y) box([$parent_size.x, 10, $parent_size.z], anchor=-y)
        align(y) box([14, 10, $parent_size.z], anchor=-y)
          align(-y) box([6, 5, $parent_size.z], anchor=center, anchor=-y, $class="hole")
            align(y) orient(y) rod(d=3.4, h=10, anchor=bottom);
  }
}

// A();
// translated(5*y+5*z) B();
// C(35);  // rear
translated(25*x) C(25);  // front
