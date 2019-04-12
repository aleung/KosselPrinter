include <../../lib/relativity.scad/relativity.scad>

length = 95;
width = 60;
height = 35;
case_thickness = 1.5;

$fn = 30;

module plate() {
  differed("hole") 
  hulled("hull")
  box([length, width-2, 0.001], $class="hull") // 下表面
  {
    translated(2*z) box([length, width, 0.001]) // 上表面
    class("normal") {
      color("red") align(z) mirrored(x) mirrored(y) translated(36*x+25*y) box([2,2,1], anchor=-z);
      mirrored(y) align(-y+z) box([$parent_size.x, 1, 2], anchor=-y-z);  // 上下沿
    }
    align(x+y-z) translated(-25*x) box([30, 8, 2], anchor=x-y-z, $class="normal") // 挂耳
      mirrored(x) translated(10*x) rod(d=4, h=3, $class="hole");
    translated(10*y, n=[-2:2]) translated(26*x, n=[-1:1]) box([length/4, 7, 5], $class="hole");
  }
}

module left_case() {
  differed("hole")
  box([30, width, 1]) {
    mirrored(y) 
      align(-y+z) box([$parent_size.x, case_thickness, height+case_thickness], anchor=y+z) {
        translated(-12*x-10*z) orient(y) rod(d=6, h=3, $class="hole");
        hulled()
          align(-y-z) box([$parent_size.x, $parent_size.y, 2], anchor=-y+z)
            align(-y-z) box([$parent_size.x, $parent_size.y+1, 0.001], anchor=-y+z);
        color("red") hulled()
          align(y+z) box([2,0.001,height-2.2], anchor=-y+z)
            align(y+z) box([1,1,$parent_size.z], anchor=-y+z);
      }
    align(-x+z) box([case_thickness, $parent_size.y+case_thickness*2, height+case_thickness+2], anchor=x+z) // 侧壁
      translated(-7*y) orient(x) rod(d=4, h=3, $class="hole");
  }
}

module right_case() {
  mirror(x) left_case();
}

plate();
translated(-40*x+(height+2)*z) left_case();
translated(40*x+(height+2)*z) right_case();
