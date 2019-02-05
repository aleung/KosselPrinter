include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

height = 130;
screw_hole_position = 6;
t = 5;
$fn = 30;

differed("cut", "not(cut)") {
  hulled(class="h") 
  {
    box([15,t,height], anchor=x-y);
    translated(20*x+25*y) rod(d=5, h=height, $class="h");
    translated((t-20)*x) rod(r=t, h=height, $class="h");
  }
  box([20,t,height], anchor=x+y, $class="cut");
  mirrored(z)
  color("red") translated(-10*x+(height/2-screw_hole_position)*z) rotated(-90*x) 
    rod(d=3.5, h=3, anchor=-z, $class="cut") align(top) rod(d=6.5, h=20, anchor=-z, $class="cut");
}

translated(-10*x) box([6, 3, 5], anchor=y);