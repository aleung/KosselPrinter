include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

$fn=36;

bar_length = 70;
bracket_length = 70;
bracket_screw_hole = 50;
bar_width = 10;
bar_height = 10;

module bar() {
  differed("hole", "not(hole)")
  box([bar_length, bar_width, 5], anchor=bottom-x) {
    align(bottom-x)
    translated(x*bracket_screw_hole+z*3.5)
    class("hole")
    rod(d=6, h=10, $fn=6, anchor=bottom-x)
    rod(d=3.3, h=30, $fn=12);

    align(top)
    hulled()
    box([$parent_size.x, $parent_size.y, 0.01], anchor=bottom)
    box([$parent_size.x, 2, bar_height-5], anchor=bottom);

    align(x-z)
    box([4, bar_width, bar_height+7], anchor=-x-z);
  }

  box([4, 28, bar_height], anchor=bottom+x)
  mirrored(y)
  align(bottom+x+y)
  box([3.5, 4, $parent_size.z], anchor=bottom-x+y);
}



// 安装轴承
module bar_bearing() {
  base_height = 6;
  differed("hole", "not(hole)") {
    translated(x*bracket_screw_hole)
    rod(d=3.1, h=30, $class="hole");

    box([bar_length, bar_width, base_height], anchor=-z-x) {
      align(z)
      hulled()
      box([$parent_size.x, $parent_size.y, 0.01], anchor=-z)
      box([$parent_size.x, 3, bar_height-base_height], anchor=-z);

      hulled()
      align(x-z) box([2, bar_width, bar_height], anchor=-x-z)
      align(x-z) box([2, bar_width, bar_height+5], anchor=-x-z);

      align(z) translated(2*x)
      orient(x) mirrored(z) {
        rod(d=3.1, h=bar_length+10, $class="hole", anchor=bottom);
        translated(20*z) {
          rod(d=11, h=10, $class="hole", anchor=bottom)
          align(top)
          translated(3*z) rod(d=6.2, h=20, $class="hole", anchor=bottom);
          // color("red") rod(d=10, h=9, $class="normal"); // debug
        } 
      }
    }

    box([4, 28, bar_height], anchor=-z+x)
    mirrored(y)
    align(-z+x+y)
    box([3.5, 4, $parent_size.z], anchor=-z-x+y);

  }
}

module bracket() {
  offset = 1;
  differed("hole", "not(hole)") {
    translated(bracket_screw_hole*x)
    class("hole")
    rod(d=3.3, h=3, anchor=top)
    align(bottom) 
    rod(d=6.2, h=50, anchor=top);

    translated(x*offset)
    hulled(class="hull")
    box([1, bar_width, 22], anchor=top-x, $class="hull")
    align(top-x)
    box([bracket_length-offset, $parent_size.y, 2], anchor=top-x) {
      align(top-x)
      box([3, $parent_size.y, 2], anchor=top+x, $class="not-hull");
    }
  }
}

// infill: 100%
module uphold() {
  box([4, 20, 10], anchor=top+x) {
    align(top-x)
    box([3, $parent_size.y, 5], anchor=top+x);
    align(top)
    hulled() {
      box([7, 10, 1], anchor=top-x);
      box([1, 10, 10], anchor=top-x);
    }
    align(top)
    box([$parent_size.x, $parent_size.y, 5], anchor=bottom);
  }
}

// infill: 100%
module topfix() {
  differed("hole", "not(hole)")
  box([5, 10, 13], anchor=bottom) {
    align(bottom) 
    box([$parent_size.x, $parent_size.y, 3], anchor=top);

    align(x)
    box([11.5, $parent_size.y, $parent_size.z], anchor=-x);

    align(bottom)
    translated(z*8)
    orient(x)
    rod(d=4, h=30, anchor=center, $class="hole");

    align(-x) 
    box([3, $parent_size.y, $parent_size.z], anchor=x)
    align(bottom-y-x)
    box([12, 8, 5], anchor=bottom-x+y)
    rod(d=3.5, h=$parent_size.z+1, $class="hole");
  }

}

module baffle() {
  gap = 1;
  box([3, bar_width, 18], anchor=x+z)
  align(x+z)
  box([gap, $parent_size.y, 10], anchor=-x+z)
  align(x+z)
  hulled()
    box([2, $parent_size.y+4, 40], anchor=-x+z)
    align(x+z)
    box([4, 6, $parent_size.z], anchor=-x+z)
  ;
}

bar_bearing();

// baffle();

// translated(y*20)
// rotated(x*90)
// bracket()
// ;

// translated(-y*30)
// uphold()
// ;

// rotated(-y*90)
// topfix();
