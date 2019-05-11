include <../../lib/relativity.scad/relativity.scad>

d_cover = 80;
d_hole = 70;
h = 8;


$fn=60;

module cone(d1, d2, h) {
  hulled()
    rod(d=d1, h=0.1, anchor=bottom)
      translated(h*z)
        rod(d=d2, h=0.1, anchor=top);
}

differed("cut")
rod(d=d_hole, h=h) {
  align(bottom) {
    cone(d_cover, d_cover-3, -2);
    rod(d=d_hole-4, h=h*2, anchor=bottom, $class="cut");
    // rotated(30*z, n=[0:5]) box([d_cover, d_hole/8, h+1], anchor=bottom, $class="cut");
  }
  align(top) {
    translated(-3*z, n=[0:3]) rotated(15*z, n=[0:11]) box([d_hole+1.2, 0.7, 0.3], anchor=top);
    // translated(-2*z, n=[0:3]) rod(d=d_hole+1, h=0.3, anchor=bottom);
  }
}

