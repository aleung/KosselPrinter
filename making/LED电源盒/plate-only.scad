include <../../lib/relativity.scad/relativity.scad>

wall_thickness = 1.5;
width = 78+5+13;
wall_height = 25;
height = 47+(6+wall_thickness)*2;

$fn = 30;

module plate() {
  differed("hole") 
  box([width, height, 2]) {
    mirrored(y)
    align(x+y-z) translated(-25*x) box([30, 8, 2], anchor=x-y-z, $class="normal") // 挂耳
      mirrored(x) translated(10*x) rod(d=4, h=3, $class="hole");
    translated(4*x) translated(10*y, n=[-2:2]) translated(23*x, n=[-1:1]) box([width/5, 7, 5], $class="hole"); // 开孔
    align(x+z) translated(47/2*y, [-1,1]) translated(x, [-5, -5-78]) 
      rod(d=8, h=3, anchor=-z)
      align(z) rod(d=3.4, h=2, anchor=z, $class="hole")
      align(-z) rod(d=6.1, h=3, anchor=z, $fn=6, $class="hole");
    color("red") align(-x+z) box([wall_thickness, $parent_size.y, wall_height], anchor=-x-z) {
      align(x+y) box([2, 10, wall_height], anchor=-x+y); // 加厚
      align(x-y) box([2, 3, wall_height], anchor=-x-y);
      align(x+y) box([12, wall_thickness, wall_height], anchor=-x+y); // 上墙
      align(+y+z) translated(-5*y-4*z) orient(x) rod(d=3, h=8, anchor=[0,0,0], $class="hole");
    }
  }
}

plate();
