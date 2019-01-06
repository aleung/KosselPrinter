include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

$fn=36;

differed("hole", "not(hole)") {
  intersected("bound", "not(bound)") {
    box([120, 82, 10], anchor=-z, $class="bound");
    hulled()
      rod(d=98, h=2, anchor=bottom)
      align(top)
      rod(d=85, h=7, anchor=bottom);
  }
  align(bottom)
  rod(d=81, h=5, anchor=bottom, $class="hole")
  align(top) {
    rod(d=63, h=5, anchor=bottom, $class="hole");

    // 小螺丝孔
    rotated(45*z)
    rotated(90*z, [0:3])
    translate(71/2*x)
    rod(d=3.4, h=2, anchor=bottom, $class="hole")
    align(top)
    rod(d=6.3, h=5, anchor=bottom, $fn=6, $class="hole");
  }

  // 大螺丝孔
  mirrored(x)
  mirrored(y)
  translate(51/2*x+73/2*y)
  rod(d=9, h=5, anchor=bottom)
  align(bottom)
  rod(d=5, h=5, anchor=bottom, $class="hole")
  align(top)
  rod(d=9.5, h=5, anchor=bottom, $class="hole");

  // 引线槽
  box([78, 15, 10], anchor=bottom, $class="hole");
}
