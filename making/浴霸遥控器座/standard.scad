include <../../lib/relativity.scad/relativity.scad>

// 标准版本，与原装尺寸一样

size_length = 86;
inner_size_length = 80;
height = 11;
inner_height = 6;
round_r = 1;

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
        box([66.6, 66.6, 0.01], anchor=bottom);
        rod(r=2, h=0.01);
      }
      translated(height*z) minkowski() {
        box([69, 69, 0.01]);
        rod(r=3, h=0.01);
      }
    }

    class("cut")
      translated(inner_height*z) minkowski() {
        box([66.6, 66.6, 2], anchor=bottom);
        rod(r=2, h=0.01);
      }

    box([inner_size_length, inner_size_length, inner_height], anchor=bottom, $class="cut");
  }
}

module inner() {
  differed("cut", "not(cut)") {
    box([inner_size_length-0.4, inner_size_length-0.4, inner_height], anchor=bottom) {
      align(top)
        box([inner_size_length-0.2, inner_size_length-0.2, 1.5], anchor=top);
      // mirrored(x) mirrored(y)
      // align(x+y-z)
      //   rotated(45*z)
      //   box([5,5,inner_height], anchor=-z, $class="cut");
    }
    translated(y*10.5) rod(d=11, h=inner_height-2.5, anchor=bottom, $fn=30, $class="cut");
  }
}

preview = true;
if (preview) {
  %body();
  color("red") inner();
}

// for generate STL
mirror(z) {
  // body();
  // inner();
}