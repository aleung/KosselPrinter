include <../../lib/relativity.scad/relativity.scad>

d = 31;
d_bottom = 45;
height = 80;
$fn=90;

module A() {
  differed("cut", "not(cut)") {
    orient(x+4*z) {
      rod(d=d+4, h=15)
        align(top) rod(d=d, h=3, anchor=top, $class="cut");
    }
    rod(d=d*2, h=20, anchor=top, $class="cut");
  }
  differed("cut", "not(cut)")
    rod(d=d-1, h=10, anchor=top)
      align(top) rod(d=d-5, h=$parent_size.h, anchor=top, $class="cut");
}

module B() {
  differed("cut", "not(cut)") {
    hull() 
      rod(d=d+4.5, h=height, anchor=top)
        align(bottom) rod(d=d_bottom, h=infinitesimal, anchor=bottom);
    class("cut") hull() 
      rod(d=d, h=height-2, anchor=top)
        align(bottom) rod(d=d_bottom-4, h=infinitesimal, anchor=bottom);
  }
}

A();
#B();