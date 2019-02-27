include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

// angel valve outlet cap

diameter = 21;       // 1/2 inch pipe
height = 10;
slit_height = 7;
thickness = 1;
$fn = 30;

module ridge() {
  rotated(45*z) translated(diameter/2*y) rotated(-45*x) box([diameter, 1.5, 1.5], anchor=y-z);
}


rotated(180*x)
intersection() {
  differed("cut", "not(cut)") {
    difference() {
      box([diameter*2, diameter*2, height*3]);
      translated(-0.01*z) rod(d=diameter, h=height, anchor=bottom);
    }
    ridge();
    translated(0.9*z) rotated(180*z) ridge(); 
    rotated(90*z, n=[0,1]) box([diameter+thickness*3, 1, slit_height], anchor=bottom, $class="cut");
  }
  rod(d=diameter+thickness*2, h=height+thickness, anchor=bottom);
}
