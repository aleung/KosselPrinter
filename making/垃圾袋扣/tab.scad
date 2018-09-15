include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

module tab() {
  box([8, 4.65, 5.55], anchor=bottom+x, $class="tab")
  align(x)
  hulled()
  align(bottom)
  box([0.1, $parent_size.y, 7], anchor=bottom)
  translated(x*12)
  align(bottom)
  box([0.1, $parent_size.y, 3], anchor=bottom);
}

tab();
