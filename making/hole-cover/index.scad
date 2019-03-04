include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

d_cover = 20;
d_hole = 16;
h = 8;


$fn=30;

module cone(d1, d2, h) {
  hulled()
    rod(d=d1, h=0.1, anchor=bottom)
      translated(h*z)
        rod(d=d2, h=0.1, anchor=top);
}

rod(d=d_cover, h=1) 
differed("cut", "not(cut)") {
  cone(d_hole-2, d_hole, h*2/3);
  translated(h*2/3*z) cone(d_hole, d_hole-2, h/3);
  class("cut") {
    cone(d_hole-5, d_hole-3, h*2/3);
    translated(h*2/3*z) cone(d_hole-3, d_hole-4, h/3);
    rotated(60*z, n=[0:3]) box([d_cover, d_hole/4, h+1], anchor=bottom);
  }
}

// %rod(d=d_hole, h=h, anchor=bottom);
