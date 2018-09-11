include <../../lib/relativity.scad> // https://github.com/davidson16807/relativity.scad

module tab() {
  box([8, 4.8, 5.8], anchor=bottom+x, $class="tab")
  align(x)
  hulled()
  align(bottom)
  box([0.1, $parent_size.y, 8], anchor=bottom)
  translated(x*10)
  align(bottom)
  box([0.1, $parent_size.y, 2], anchor=bottom);
}

translated(-y*50)
tab();