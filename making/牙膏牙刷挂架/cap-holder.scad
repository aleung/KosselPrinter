include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

length = 30;
depth = 15;
height = 50;
thickness = 2;
$fn = 30;

// mirror(x)
box([10, 6.7, 8.7])
align(x+z)
box([2, depth, height], anchor=z) 
box([5, 2, height], anchor=-x)
{
  align(-z) rotated(-z*45) box([length, 4, 8], anchor=-x+y-z)
      translated(-x*9, n=[0,1]) align(x-y-z) rotated(y*15) box([4, 4, 18], anchor=x-y-z);
}
