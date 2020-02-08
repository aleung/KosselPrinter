include <../../lib/relativity.scad/relativity.scad>

// 标准版本，与原装尺寸一样

// Print settings: 
// Layer height 0.3mm
// Rectilinear infill 10%
// Bottom fill pattern: Archimedean Chords
// No support
// Pause at hole top to put in magnet

size_length = 86;
inner_size_length = 80;
magnet_height = 3;
inner_height = magnet_height + 2.5;
height = inner_height+5;
round_r = 1;
all_in_one = false;

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
        box([66.6, 66.6, 5], anchor=bottom);
        rod(r=2, h=0.01);
      }

    if (all_in_one)
      translated(10.5*y+0.6*z) rod(d=11, h=magnet_height+0.4, anchor=bottom, $fn=30, $class="cut");
    else
      box([inner_size_length, inner_size_length, inner_height], anchor=bottom, $class="cut");
  }
}

module inner() {
  differed("cut", "not(cut)") {
    box([inner_size_length-0.4, inner_size_length-0.4, inner_height], anchor=bottom) {
      align(top)
        box([inner_size_length-0.2, inner_size_length-0.2, 1.5], anchor=top);
    }
    // translated(y*10.5) rod(d=11, h=inner_height-2.5, anchor=bottom, $fn=30, $class="cut");
    translated(10.5*y+0.9*z) rod(d=11, h=magnet_height+0.4, anchor=bottom, $fn=30, $class="cut");
  }
}

if ($preview) {
  intersected("intersection", "not(intersection)") {
    body();
    translated(-1*z)
      color("red") inner();
    class("intersection") box([100, 100, 50], anchor=x);
  }
} else {
  // for generate STL
  mirror(z) {
    translated(x*100) body();
    inner();
  }
}
