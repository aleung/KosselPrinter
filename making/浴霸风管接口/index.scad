include <../../lib/relativity.scad/relativity.scad>

$fn=60;

module A() {
  differed("hole", "not(hole)") {
    rod(d=102, h=16, anchor=bottom)
    hulled("hulled")
    align(top)
    rod(d=102, h=8, anchor=bottom, $class="hulled")
    align(top)
    rod(d=120, h=1, anchor=bottom, $class="hulled")
    align(top)
    rod(d=99, h=20, anchor=bottom, $class="normal")
    align(top)
    rotated(45*z, n=[0:7]) translated(49*x) rod(d=2, h=20, anchor=top, $fn=10)
    ;

    rod(d=93, h=100, $class="hole");
  }
}

module B() {
  differed("hole", "not(hole)") 
  hulled("hulled")
  rod(d=120, h=1, anchor=bottom, $class="hulled")
  rod(d=110, h=3, anchor=bottom, $class="hulled")
  rod(d=100, h=5, $class="hole")
  ;
}

A();
translated(28*z) color("red") B();
