include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

// -- small size
// rope_d = 1.5;
// a = 8;    // >> rope_d *4
// c = 2.5;  // >> flange_width
// thickness = 1.5;
// b = 2;


// -- normal size
rope_d = 3;
a = 20;
c = 5;
thickness = 2;
b = 3;


flange_width = 1.5;
gap = 0.2;

middle_l = a + rope_d * 5;
body_length = middle_l + a*2 + rope_d*4;
body_width = a + rope_d * 2 + c * 2;
body_height = rope_d + thickness;
cover_width = body_width + gap*2 + b*2;

module zigzag(w, h) {
  mirrored(y) translated(w*y) 
    translated(rope_d/2*x-rope_d/2*y, n=[1:(w-rope_d)/rope_d*2]) box([rope_d/3,rope_d/3,h], anchor=-z);
}

module wedge(l,w,h,with_zigzag=false) {
  side = w*0.707;
  hull() mirrored(x) translated((l-w)/2*x)
    rotated(45*z) box([side, side, h], anchor=-z);
  if (with_zigzag)
    mirrored(x) translated((l-w)/2*x)
      zigzag(w/2, h);
}


module body() {
  differed("cut", "not(cut)") {
    box([body_length, body_width, body_height], anchor=-z);
    class("cut") {
      wedge(l=middle_l+a*2, w=a+gap*2, h=body_height+0.01);
      translated(thickness*z) {
        box([body_length+0.01, rope_d*2, rope_d+0.01], anchor=-z);    
        wedge(l=middle_l+a*2, w=a+rope_d*2, h=body_height+0.01, with_zigzag=true);
      }
      mirrored(y) translated(body_width/2*y) {
        box([a+rope_d*2, flange_width, body_height+1], anchor=y-z);
        rotated(x*45) box([body_length+0.1, 1.414*flange_width, 1.414*flange_width]);
      }
    } 
  }
}

module cover() {
  mirrored(y) translated(cover_width/2*y) {
    box([a, b, body_height], anchor=y-z);
    hull() {
      box([a, b+flange_width, 0.01], anchor=y-z);
      box([a, b, flange_width], anchor=y-z);
    }
  } 
  translated(body_height*z) box([a, cover_width, thickness], anchor=-z);
  wedge(a,a,body_height, with_zigzag=true);
  difference() {
    box([a/2, a, body_height], anchor=-x-z);
    mirrored(y) translated(a/2*x+a/2*y) rotated(z*45) box([a/4, a/4, body_height], anchor=-z);
  }
}

body();
mirrored(x) translated(-(a+rope_d*1.5)*x) 
  cover();
