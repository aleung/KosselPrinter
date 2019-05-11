include <../../lib/relativity.scad/relativity.scad>

box([10, 10, 5])
align(-x+z)
box([$parent_size.x+10, $parent_size.y, 3], anchor=-x-z);