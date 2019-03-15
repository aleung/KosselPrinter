include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

AC = 105;
BC = 13;
AB = AC - BC;

JK = 9;
KL = 13;
JM = 61;
MK = JM - JK;

HA = 2;
HB = 14.5;
HC = 9;
HF = 35;

TOP_HEIGHT = HF - HC;
FAN_FACE_WIDTH = 58;

WALL_HIGHT_1 = HA + HB;
WALL_HIGHT_2 = WALL_HIGHT_1 + HC;

SURFACE = 1.5;
WALL_THICKNESS = 1.5;

$fn = 30;

module ear(fn) {
  box([10, 18, 3], anchor=-x+y-z) {
    rod(d=3.4, h=5.01, $class="cut");
      // align(top) rod(d=6.3, h=2, anchor=top, $fn=fn, $class="cut");
    translated(y, n=[-8,-4,4,8]) align(z) box([10, WALL_THICKNESS, 15], anchor=-z);
    align(x+z) rotated(-28*y) box([12, 18, 18], anchor=-x-z, $class="cut");
  }
}

module bottom() {
  differed("cut", "not(cut)")
  box([AC, JM, SURFACE]) {
    // walls
    mirrored(y) align(y-z)
      box([AC+WALL_THICKNESS*2, WALL_THICKNESS, WALL_HIGHT_2+SURFACE], anchor=-y-z);
    align(x-z)
      box([WALL_THICKNESS, JM, WALL_HIGHT_1+SURFACE], anchor=-x-z)
        align(-y+z) translated(JK*y)
          box([WALL_THICKNESS+0.01, KL, 12], anchor=-y+z, $class="cut");
    mirrored(y) align(x+y+z)
      box([WALL_THICKNESS, 2, WALL_HIGHT_2], anchor=-x+y-z);
    align(-x-z)
      box([WALL_THICKNESS, JM, WALL_HIGHT_2+SURFACE], anchor=x-z);
    // rib
    mirrored(x) align(x+z)
      box([4, JM, HA], anchor=x-z);
    align(y+z)
      box([AC, 4, 2], anchor=y-z);
    // button hole
    align(x+y+z) translated(-39*x+19*z)
      box([7, WALL_THICKNESS+0.01, WALL_HIGHT_2-19], anchor=-y-z, $class="cut");
    // ear
    mirrored(x) align(x+y-z) ear(30);
    mirrored(y) translated(-11*x+WALL_HIGHT_2*z) align(x+y+z) children();
    translated(26*x+WALL_HIGHT_2*z) align(-x-y+z) rotated(180*z) children();
  }
}

module top() {
  differed("cut", "not(cut)")
  box([AC, JM, SURFACE]) {
    align(z) translated(-3*y) box([AC-20, WALL_THICKNESS, 6], anchor=z);
    align(-y+z) box([AC, WALL_THICKNESS, 6], anchor=y+z);
    align(-x+z) translated(10*x)
      box([WALL_THICKNESS, JM, TOP_HEIGHT-6], anchor=z);
    align(-x+y+z)
      box([20, WALL_THICKNESS, TOP_HEIGHT-6], anchor=-x-y+z);
    align(-x-y+z)
      box([11, WALL_THICKNESS, TOP_HEIGHT-6], anchor=-x+y+z);
    align(x+z) translated(-15*x)
      box([WALL_THICKNESS, JM, TOP_HEIGHT-3], anchor=x+z)
        mirrored(y) align(y+z) 
          box([WALL_THICKNESS, 4, HF], anchor=y+z)
            align(y+z) box([4, WALL_THICKNESS, HF], anchor=y+z);
    align(-x-y+z) translated(35*x)
      box([WALL_THICKNESS, 4, HF], anchor=-x-y+z)
        align(-y+z) box([4, WALL_THICKNESS, HF], anchor=-y+z);
    // wall
    mirrored(y) align(x-y+z)
      box([30, WALL_THICKNESS, TOP_HEIGHT], anchor=x+y+z);
    align(-x-y+z) translated(26*x)
      box([25, WALL_THICKNESS, TOP_HEIGHT], anchor=-x+y+z);
    align(x+y+z) translated(-30*x)
      box([FAN_FACE_WIDTH, WALL_THICKNESS, TOP_HEIGHT], anchor=x-y+z);
    // ear
    mirrored(y) translated(-11*x-TOP_HEIGHT*z) align(x-y+z) children();
    translated(44*x-TOP_HEIGHT*z) align(-x-y+z) children();
    // fan
    align(x+y+z) translated(-x, n=[30,89]) box([WALL_THICKNESS, 27, TOP_HEIGHT-5], anchor=-x+y+z);
    align(z) translated(-6*x+2*y)
      rotated(-32*x) 
        box([FAN_FACE_WIDTH, 35, SURFACE*1.5], anchor=-y+z) {
          align(z) 
            box([$parent_size.x, $parent_size.y, 50], anchor=-z, $class="cut")
              align(-z) rod(d=29, h=SURFACE+5, anchor=z, $class="cut")
                translated(12.1*x, [-1,1]) translated(12.1*y, [-1,1])
                  rod(d=3.3, h=SURFACE+5, $class="cut");
          align(-z) 
            box([$parent_size.x+5, $parent_size.y, 20], anchor=z, $class="cut");
        }
  }
}

bottom() {
  rotated(-90*z) orient(-z) ear(30);
};

translated((WALL_HIGHT_1+HF)*z) top() {
  rotated(-90*z) ear(6);  
};