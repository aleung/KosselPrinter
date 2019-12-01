include <../../lib/relativity.scad/relativity.scad>

$fn=60;

hull() {
  translated(2.5*z) minkowski() {
    box([73, 73, 0.01], anchor=bottom);
    rod(r=2, h=0.01);
  }
  minkowski() {
    box([69, 69, 0.01]);
    rod(r=1, h=0.01);
  }
}

differed("cut", "not(cut)")
  rod(d=50, h=3.5, anchor=bottom)
  align(top)
  rod(d=47, h=1, anchor=top, $class="cut");
