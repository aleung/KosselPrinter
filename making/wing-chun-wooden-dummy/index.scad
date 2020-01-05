// http://blogdodido-dido.blogspot.com/2011/01/sobre-o-muk-yan-jong.html

// Relativity SCAD library
// https://raw.githubusercontent.com/aleung/relativity.scad/master/relativity.scad
include <../../lib/relativity.scad/relativity.scad>

body_height = 125;  // 140
$fn=30;

module body() {
  differed("cut", "not(cut)", "arm,leg") {
    rod(d=22, h=125, $fn=80, anchor=z)
      align(top) {
        translated(-33*z) {
          rotated(17.75*z) box([30, 5, 5.2], anchor=top, $class="cut") align(top) class("arm") children();
          rotated(-17.75*z) box([30, 5, 5.2], anchor=bottom, $class="cut") align(top) class("arm") children();
        }
        translated(-60*z)
          box([30, 5, 5.2], anchor=top, $class="cut") align(top) class("arm") children();
        translated(-110*z) {
          rotated(18*y) box([30, 5.1, 5.2], anchor=top, $class="cut");
          class("leg") children();
        }
        mirrored(z) hulled() rod(d=22, h=0.01) rod(d=18, h=2, anchor=-z);
      }
  }
}

module leg() {
  $fn=18;
  length = 50;
  box([0.01, 0.01, 0.01]) // anchor
  differed("cut", "not(cut)", "tenon") {
    rotated(18*y) box([28, 4.6, 4.5], anchor=top, $class="tenon") {
      class("normal") translated(-4*x) minkowski() {
        align(x) box([26, 4, 6], anchor=-x);
        orient(x) ball(r=1.5);
      }
      translated(25*x+12.2*z) rotated(52*y) {
        minkowski() {
          align(x) box([length, 4, 6], anchor=-x, $class="normal");
          orient(x) ball(r=1.5, $class="normal");
        }
        translated((length-5)*x) align(x) color("red") box([14, 4.6, 4.5], $class="tenon");
      }
    }
    translated(-67.5*z) rod(d=160, h=20, $class="cut");
    rod(d=22, h=200, $class="cut");
  }
}

module arm() {
  $fn=24;
  differed("cut")
  box([30, 4, 4], anchor=z) {
    align(x) translated(-4*x) 
    hulled()
      orient(x) rod(d=6.5, h=0.01, anchor=bottom)
        align(top) rod(d=4.5, h=26, anchor=bottom)
          align(top) ball(d=4.5);

    // minkowski() {
    //   hulled()
    //     orient(x) rod(d=4.5, h=0.01, anchor=bottom)
    //       align(top) rod(d=3, h=29, anchor=bottom);
    //   ball(r=1);
    // }

    translated(-13*x) rod(d=2.5, h=10, $class="cut");
  }
}

module foundation() {
  differed("cut") {
    translated(52*x) rotated(70*y) box([100, 5.3, 5.1], $class="cut");
    translated(15*x)
      box([140, 70, 10], anchor=-z)
        box([41,41, 5], $class="cut");  // for putting weight inside
  }

}

module pin() {
  hulled()
    box([1, 2.1, 1.8])
      align(-z) translated(10*x)
        box([1, 0.9, 1.8], anchor=-z);
}

if ($preview) {
  body() {
    attach("leg") leg();
    attach("arm") arm();
  }
  translated(-178*z) foundation();
} else {
  translated(-60*y) body();
  rotated(180*x) foundation();

  translated(-50*x+60*y) rotated(-90*y) arm();
  translated(120*y) rotated(-90*x) leg();

  translated(30*x-40*y) pin();
}
