include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

length = 30;
depth = 15;
height = 50;
thickness = 2;
$fn = 30;

module pillar() {
  box([8, 3, 4], anchor=x-y-z)
    align(-x-z) rod(d=5, h=20, anchor=-z)
      align(z) sphere(d=5);
}


// mirror(x)
differed("hole", "not(hole)")
box([10, 6.7, 8.7])
align(-x-y+z)
box([5, 12, height], anchor=-y+z) {
      translated(z*10, n=[-1:1]) box([6, 5, 8], $class="hole");
  align(x-y) box([4, 2, height], anchor=x-y);
  align(x-z+y) box([thickness, 52, 11], anchor=x+y-z) {
    translated(y*10, n=[-2:2]) box([9, 5, 3], $class="hole");
    align(-x-z) box([3, 52, thickness], anchor=x-z);
    align(-x-y-z) translated(y*20, n=[0,1]) pillar();
  }
}

