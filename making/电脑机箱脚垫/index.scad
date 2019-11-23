include <../../lib/relativity.scad/relativity.scad>

// printing infill: 10%

d = 45;
center_distance = 172;
h = 65;
bar_width = 15;
bar_height = 5;

$fn=30;

module X(d, h) {
  hull()
  translated(center_distance/2*x, n=[-1:1]) rod(d=d, h=h, anchor=bottom);
}

// differed("hole", "not(hole)") {
//   X(d+5, 8);
//   class("hole") translated(3*z) X(d, 6);

//   mirrored(x) translated(center_distance/2*x) {
//     rod(d=d+5, h=h, anchor=top);
//     // low infill, use hole wall to strengthen
//     rotated(30*z, n=[1:12]) translated((d/2-5)*x) rod(d=3, h=h-1, anchor=top, $class="hole", $fn=6);
//   } 
// }

module pillar() {
  differed("hole", "not(hole)") {
    rod(d=d+5, h=h, anchor=top);
    rod(d=d+5, h=5, anchor=bottom);
    rod(d=d, h=5, anchor=bottom, $class="hole")
      align(bottom) {
        // low infill, use hole wall to strengthen
        rotated(36*z, n=[1:9]) 
          translated((d/2-5)*x - 1*z) rod(d=3, h=h-2, anchor=top, $class="hole", $fn=6);
        box([d+10, bar_width, 10], anchor=-x-z, $class="hole");
        box([d+10, bar_width, bar_height], anchor=-x+z, $class="hole");
      }
  }
}

module bar_end(width) {
  hull() {
    box([10, width, 30], anchor=-x+z);
    box([d/2-5, width, bar_height], anchor=-x+z);
  }
}

module bar() {
  mirrored(x) translated(-center_distance/2*x)
    bar_end(bar_width-0.6);
  box([center_distance, bar_width-0.6, bar_height], anchor=top);
}

// difference() {
//   pillar();
//   bar_end(bar_width);
// }

translated(center_distance/2*x) color("red") bar();