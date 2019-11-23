include <../../lib/relativity.scad/relativity.scad>

h_top = 5;
h_bottom = 8;

$fn=16;

module A() {
  difference() {
    intersected("not(box)", "box") {
      rod(d=161, h=25, anchor=top, $fn=120);
      translated(70*y) 
        box([40, 11, 50], anchor=-y, $class="box");
    }
    translated(75*y) {
      rod(d=3.5, h=50);
      rod(d=7, h=20, anchor=top);
    }
  }

  translated(80*y) 
  box([8, 5, 7], anchor=-y+z);
}


module B() {
  intersected("not(box)", "box") {
    rod(d=169, h=h_top, anchor=bottom);
    rod(d=169, h=h_bottom, anchor=top);
    rod(d=175, h=h_bottom-1.5, anchor=top);
    translated(77*y) box([47, 15, 20], anchor=-y, $class="box");
  }
  translated(77*y) 
  differed("hole", "not(hole)")
  box([47, 2, 8], anchor=y+z) {
    mirrored(x)
      align(x-y+z)
      box([14, 12, 15], anchor=x+y+z)
        rod(d=3.5, h=20, $class="hole");
    align(-y+z) {
      box([14, 12, 15], anchor=y+z)
        rod(d=3.5, h=20, $class="hole")
        align(top)
        rod(d=6.1, h=10, $fn=6, anchor=top, $class="hole");
      box([47, 12, 5], anchor=y+z);
    }
  }
  
}

A();
