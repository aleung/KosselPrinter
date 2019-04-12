include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

mirrored(y)
box([13, 18, 6]) {
  align(-x+y-z) box([33, 4, 10], anchor=-x-y-z);
  align(x+z)
    multmatrix([
      [1,0,-0.3,0],
      [0,1,0,0],
      [0,0,1,0],
      [0,0,0,1],
    ]) box([10, 4, 4], anchor=x-z);
}
