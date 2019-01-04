include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

$fn=12;

bar_length = 50;
bar_width = 10;
bar_height = 8;

module bar() {
  box([bar_length, bar_width, 5], anchor=bottom-x) {
    align(bottom+x)
    differed("hole", "not(hole)")
    box([6, $parent_size.y, 2], anchor=bottom-x)
    rod(d=3.3, h=$parent_size.z+1, $class="hole");

    align(top)
    hulled()
    box([$parent_size.x, $parent_size.y, 0.01], anchor=bottom)
    box([$parent_size.x, 2, bar_height-5], anchor=bottom);
  }

  box([4, 28, bar_height], anchor=bottom+x)
  mirrored(y)
  align(bottom+x+y)
  box([3.5, 4, $parent_size.z], anchor=bottom-x+y);
}

module bracket() {
  offset = 1;
  translate(x*offset)
  differed("hole", "not(hole)")
  hulled(class="hull")
  box([1, 10, 22], anchor=top-x, $class="hull")
  align(top-x)
  box([bar_length-offset, bar_width, 2], anchor=top-x) {
    align(top+x)
    box([6, $parent_size.y, 2], anchor=top-x, $class="not-hull")
    rod(d=3.3, h=$parent_size.z+1, $class="hole");

    align(top-x)
    box([3, $parent_size.y, 2], anchor=top+x, $class="not-hull");
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

// bar();

// translated(y*20)
// rotated(x*90)
// bracket()
// ;

// translated(-y*30)
// uphold()
// ;

rotated(-y*90)
topfix();
