include <../../lib/relativity.scad/relativity.scad>

$fn=30;

differed("hole", "not(hole)") {
  box([101.6, 18.3, 5], anchor=-y-z) {
    mirrored(x)
    align(x-z)
      box([5, $parent_size.y, 12], anchor=x-z);
  }
  mirrored(x) {
    translated(61.72/2*x+5*y) rod(d=3.5, h=20, $class="hole");
    translated(50*x+13.3*y+6*z) orient(x) rod(d=3.3, h=20, $class="hole");
    translated(9.15*y) {
      box([52, 11, 20], $class="hole");
      translated(40*x) box([8, 11, 20], $class="hole");
    } 
  }
}
