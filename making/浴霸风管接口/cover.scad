include <../../lib/relativity.scad/relativity.scad>

$fn=60;

module ring(d_in, d_out, h) {
  differed("hole", "not(hole)") {
    rod(d=d_out, h=h, anchor=bottom);
    rod(d=d_in, h=h, anchor=bottom, $class="hole");
  }
}

intersection() {
  union() {
    ring(90, 153, 2);
    ring(150, 153, 5);
  }
  box([200, 200, 10], anchor=x);
}
