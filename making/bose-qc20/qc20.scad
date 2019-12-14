include <../../lib/relativity.scad/relativity.scad>

wall = 1.8;
circle_x = 40.5;
circle_y = 24.5;
circle_pad_hight = 1.2;
wire_ext_length = 15;
round_r = wall;

$fn=18;

module bottom() {
  differed("cut", "not(cut)") {
    box([circle_x + wall*2, circle_y + wall*2, wall], anchor=top) {
      mirrored(x) mirrored(y)
        align(x+y+z) box([wall, (circle_y - 10)/2 + wall, 5], anchor=x+y-z);
      // wall
      mirrored(y)
        align(y+z) box([$parent_size.x, wall, 4], anchor=y-z)
          align(-x-y) translated(x*wall) box([12, 0.5, $parent_size.z], anchor=-x-y, $class="cut");
      // switch hole
      translated(x*(wall+12)) align(-x+y+z) box([9, wall+0.01, 4.5], anchor=-x+y-z, $class="cut")
        align(-y-z) box([17, 2, 0.7], anchor=y+z) {
          align(y+z) box([$parent_size.x, 1.1, 5], anchor=-y-z);
          align(-x-y+z) box([11, 1, circle_pad_hight], anchor=-x+y-z, $class="normal");
        }
      // usb hole
      translated(-x*(wall+16)) align(x-y+z) box([9, wall+0.01, 4], anchor=x-y-z, $class="cut");
      // wire
      align(-x-z) box([wire_ext_length, $parent_size.y, 5+wall], anchor=x-z)
        align(z) mirrored(y) translated(10*y) rod(d=4.3, h=3.2, anchor=top, $class="cut");
      align(-x+z) box([wire_ext_length, 5, 5], anchor=x-z, $class="cut");
      translated((wall-1)*x) align(-x+z) box([1.5, 19, 5], anchor=x-z, $class="cut");
      // circle pad
      mirrored(y)
        align(x+y+z) box([wall+1, wall+2, circle_pad_hight], anchor=x+y-z);
      // led hole
      align(-x+z) translated(x, n=[wall+2, wall+9])
        translated(5*y) rod(d=3, h=wall/2, anchor=top, $class="cut", $fn=12);
      // end box
      align(x-z) box([6, $parent_size.y, 5+wall], anchor=-x-z) {
        translated(-0.01*x+0.01*z) align(-x+z) box([4, 10, 5], anchor=-x+z, $class="cut");
        align(z) mirrored(y) translated(10*y) rod(d=4.3, h=3.2, anchor=top, $class="cut");
      }
    }

  }
}

module top() {
  wall_height = 6.3;
  differed("cut", "not(cut)") {
    box([circle_x + wall*2, circle_y + wall*2, wall], anchor=bottom) {
      mirrored(x) mirrored(y)
        align(x+y-z) box([wall, (circle_y - 10)/2 + wall, 5], anchor=x+y+z);
      // wall
      mirrored(y) {
        align(y-z) box([circle_x, wall, wall_height], anchor=y+z);
        align(y-z) box([20, wall+(circle_y-22)/2, 5], anchor=y+z);
      }
      // switch hole
      translated(x*(wall+12)-(wall_height-0.6)*z) align(-x+y-z) box([9, wall*2, 0.6], anchor=-x+y+z, $class="cut");
      // wire out
      align(-x+z) box([wire_ext_length, $parent_size.y, 5+wall], anchor=x+z)
        align(-z) mirrored(y) translated(10*y) rod(d=4, h=3, anchor=top);
      align(-x-z) box([wire_ext_length+0.01, 5, 5], anchor=x+z, $class="cut");
      translated((wall-1)*x) align(-x-z) box([1.5, 19, 5], anchor=x+z, $class="cut");
      // end box
      align(x+z) box([6, $parent_size.y, 5+wall], anchor=-x+z) {
        translated(-0.01*x-0.01*z) align(-x-z) box([4, 10, 5], anchor=-x-z, $class="cut");
        align(-z) mirrored(y) translated(10*y) rod(d=4, h=3, anchor=top);
      }
    }

  }
}

module circle() {
  %box([circle_x, circle_y, 3.5], anchor=bottom);
}

intersection() {
  color("red")
  translated(-4.5*x) 
  minkowski() {
    box([65.3-round_r*2, 28.2-round_r*2, 11.8-round_r], anchor=bottom);
    ball(r=round_r);
  }
  
  union() {
    bottom();
    translated(10*z) top();    
  }
}
