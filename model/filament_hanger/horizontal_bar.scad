include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

height = 22;
$fn=18;

module bar() {
  translated(-0.5*y+z*10) box([100, 10, 44], anchor=-x+y-z);
}

// print on y-z plate, no support
module fixing() {
  intersection() {
    differed("cut", "not(cut)") {
      rotated(30*z)
        box([20, 30, height], anchor=-x+y-z) {
          align(y-z) box([5.8, 3, 3], anchor=-y-z);
          translated(-5*z) align(y+z) orient(y) 
            rod(d=3.5, h=2, anchor=top, $class="cut") 
              align(bottom) rod(d=6.5, h=40, anchor=top);
        }
      box([20, 20, height], anchor=-x+y-z);
      translated(-2.5*y+z*8)
        class("cut") minkowski() {
          box([50, 8, height], anchor=-x+y-z);
          orient(x) rod(d=3, h=20);
        }
    }
    box([20*cos(30), 30, height], anchor=-x-z);
  }
}

fixing();
translated(100*x) mirror(x) fixing();
%bar();
