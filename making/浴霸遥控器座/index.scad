include <../../lib/relativity.scad/relativity.scad>

size_length = 93;
height = 20.5;
inner_height = 16.5;
round_r = 2;

$fn=18;

module body() {
  differed("cut", "not(cut)") {
    minkowski() {
      box([size_length-round_r*2, size_length-round_r*2, height-round_r], anchor=bottom);
      ball(r=round_r);
    }
    box([size_length, size_length, 10], anchor=top, $class="cut");
    
    class("cut") hull() {
      translated((height-2)*z) minkowski() {
        box([67, 67, 0.01], anchor=bottom);
        rod(r=2, h=0.01);
      }
      translated(height*z) minkowski() {
        box([69, 69, 0.01]);
        rod(r=3, h=0.01);
      }
    }

    class("cut")
      translated(inner_height*z) minkowski() {
        box([67, 67, 2], anchor=bottom);
        rod(r=2, h=0.01);
      }

    box([86, 87, inner_height], anchor=bottom, $class="cut");
  }
}

module cover() {
  differed("cut", "not(cut)")
    box([85.5, 86.5, 4.2], anchor=top)
    align(bottom)
    box([80, 80, 3], anchor=bottom, $class="cut");

  translated(8*y) rod(d=2.5, h=3, anchor=top);
  translated(15.5*x+24*y) rod(d=1.5, h=3, anchor=top);
  translated(-17*x+24*y) rod(d=2.5, h=3, anchor=top);
}

%body();
color("red") translated(inner_height*z) cover();