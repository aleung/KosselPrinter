// Relativity SCAD library
// https://raw.githubusercontent.com/aleung/relativity.scad/master/relativity.scad
include <../../lib/relativity.scad/relativity.scad>

wide = 10;
wide_hook = 4;

r1 = 4;
r2 = 3;
$fn=18;

module A() {
  differed("cut") {
    color("red") hull() {
      translated((r1+3)*x + (30.8-r1)*y) rod(r=r1, h=wide);
      translated((19-r2)*x + (1.5+r2)*y) rod(r=r2, h=wide);
      translated(r2*y) rod(r=r2, h=wide);
    }
    translated(-5.5*x+23*y) rod(d=5, h=wide);
    box([8, 23, wide], anchor=x-y);
    color("blue") translated(-4*x+3*y) rod(r=5, h=wide);
    class("cut") hull()
      translated(y, n=[11,30]) rod(r=3, h=wide+0.01);

    // holes
    translated(9*x+16*y) rod(d=4, h=wide+0.01, $class="cut");
    translated(10*x+8*y) rod(d=6, h=wide+0.01, $class="cut");
    translated(-4*x+3*y) rod(d=3.4, h=wide+0.01, $class="cut");

    class("cut") translated(10*y+(wide_hook+2)*z) minkowski() {
      box([20, 40, wide], anchor=x-y);
      ball(r=2);
    }
  }
}

module B() {
  differed("cut") hulled("hull") {
    box([85, 5, wide+6], anchor=x) {
      class("cut") translated(-3*x) minkowski() {
        align(-x) box([5, 10, 3], anchor=-x);
        ball(r=2);
      }
      align(-x) rod(d=5, h=wide+6, anchor=center);
      // 斜杆
      align(-x-z) translated(15*x) rotated(-30*z) box([83, 5, 4], anchor=-x-z);
      // 竖杆
      align(x-z) translated(0*x) box([3, 41, 3], anchor=x+y-z)
        align(x-y-z) box([4, 10, 4], anchor=-x-z);
      align(-z) translated(15*x) box([3, 23, 3], anchor=x+y-z);
    }
    rod(r=5, h=wide+6);
    rod(r=6, h=wide+0.3, $class="cut");
    rod(d=3.4, h=wide+10, $class="cut");
  }
}

// A();
// translated(36*x+10*y) rotate([0, 180, 0]) mirror([0,0,1]) A();

// translated(-4*x+3*y)
// B();
translated(40*x) rotate([0, 180, 0]) mirror([0,0,1]) B();
