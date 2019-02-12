include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

/* [Primary parameters] */
height = 8;

/* [change on necessary] */
thickness = 2;
flanch_size = 3;
$fn = 30;
debug = false;

/* [Hidden] */
d1 = 13.5;
angle = 35;

d2 = d1 + thickness * 2;
offset1 = height * tan(angle) / 2;
offset2 = d1 * (1/cos(angle) - 1) / 2;

module body(h, d) {
  hull()
    translated((offset1+offset2)*x, n=[-1,1]) {
      rod(d=d, h=h);
    }
}

module flanch() {
  hull() {
    body(flanch_size*1.3, d2);
    translated(-flanch_size*0.3*z) body(flanch_size*0.7, d2+flanch_size*2);
  }
}

mirrored(x) mirrored(y) translated(30*x+20*y)
differed("cut", "not(cut)") {
  body(height, d2);
  mirrored(z) translated(-height/2*z) flanch();
  rotated(angle*y) hull() {
    rod(d=d1, h=height*3, $class="cut");
    translated(-4*x-6*y) rod(d=d1-1, h=height*10, $class="cut");
  } 
  translated((0.1+d2/2)*y) rotated(90*x) color("red") class("cut") {
    rod(d=4, h=d2/2);
    hull() {
      rod(d=4, h=1.5);
      rod(d=6, h=0.1);
    }
    rod(d=8, h=5, anchor=top);
  }  
  translated(-d1/2*y) box([d1*10, 10, height+10], anchor=y, $class="cut");
}

if (debug) translated(30*x+20*y) {
  color("red")
    rotated(angle*y)
      rod(d=d1, h=height*3); 

  // color("orange") translated(-4.1*x-6*y)
  //   rotated(angle*y)
  //     rod(d=d1, h=height*3); 
}
