include <../../lib/relativity.scad/relativity.scad>

hook_thickness = 3;
hook_width = 8;
hook_length = 23;
$fn=18;

module hook() {
  box([26.5, hook_thickness, hook_width]) {
    align(-x+y) box([hook_thickness, 13, $parent_size.z], anchor=x+y);
    differed("cut", "not(cut)")
      align(x+y) box([hook_thickness, hook_length, $parent_size.z], anchor=-x+y)
        translated(-5*y)
        align(-x) orient(x) rod(d=hook_width, h=5, anchor=bottom)
          align(bottom) rod(d=3.5, h=10, anchor=bottom, $class="cut")
            hull()
              align(bottom) rod(d=6.2, h=0.01)
                align(bottom) rod(d=3.5, h=2, anchor=bottom);
              

  }
}

module body() {
  width_out = 58;
  width_in = 39;
  round_r_out = 3;
  round_r_in = 1.5;
  height = 60;
  depth = 10;

  intersection() {
    box([width_out, height, depth+2], anchor=y+z);

    differed("cut", "not(cut)") {
      minkowski() {
        box([width_out-round_r_out*2, height, depth+2-round_r_out], anchor=y+z);
        orient(y) ball(r=round_r_out, h=0.1);
      }

      class("cut") minkowski() {
        box([width_in-round_r_in*2, height+1, depth-round_r_in], anchor=y+z);
        orient(y) rod(r=round_r_in, h=0.1);
      }
      
      mirrored(x)
      translated(width_in/2*x) box([hook_width, hook_length, hook_thickness], anchor=-x+y+z, $class="cut")
        translated(-5*y) align(-z) rod(d=hook_width+0.5, h=2, anchor=top)
          rod(d=3.1, h=6, anchor=top);

      translated((-hook_thickness-1)*z) orient(z+y) box([100, 10, 20], anchor=-y+z, $class="cut");
    }
  }

  mirrored(x)
    translated(width_in/2*x - (height-3)*y) rod(r=3, h=depth, anchor=top);
}

hook();
body();
