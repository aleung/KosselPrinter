include <../../lib/relativity.scad/relativity.scad>

// 机箱进风口
in_x = 152;
in_z = 72;
in_edge = 4;
in_thickness = 8;
// 风扇上罩
fan_d = 95;
fan_x = 89;
fan_y = 108;
fan_z = 40;
// 壁，肋
wall_thickness = 3;
rib = 3;

$fn=30;

in_width = in_x - in_edge*2;
in_height = in_z + in_edge*2;

function rib_z(y) = in_height - (in_height - fan_z) / (fan_y + fan_d/2 - in_thickness) * (y - in_thickness);

module A() {
  intersection() {
    union() {
      differed("hole", "not(hole)") {
        hull() {
          translated(in_edge*x) box([in_width, in_thickness, in_height], anchor=-x-y-z);
          translated(fan_x*x + fan_y*y) rod(d=fan_d, h=fan_z, anchor=bottom);
        }
        class("hole") hull() {
          translated((in_edge+wall_thickness)*x + wall_thickness*z)
            box([in_width-wall_thickness*2, in_thickness, in_height-wall_thickness*2], anchor=-x-y-z);
          translated(fan_x*x + fan_y*y + wall_thickness*z) 
            rod(r=fan_d/2-wall_thickness, h=fan_z-wall_thickness*2, anchor=bottom);
        }
        // 风扇洞  
        translated(fan_x*x + fan_y*y) 
          rod(r=fan_d/2-wall_thickness, h=fan_z-wall_thickness, anchor=bottom, $class="hole");
        // z平面加强肋
        color("red") translated(in_thickness*y) box([in_x, fan_y+fan_d, rib], anchor=-x-y-z);
        color("red") translated(rib_z(fan_y)*z) box([in_x, fan_y, rib*2], anchor=-x-y);
        color("red") translated(rib_z(fan_y/2)*z) box([in_x, fan_y/2, rib*2], anchor=-x-y);
        // 加强肋
        translated(fan_y*y, n=[0.5, 1]) box([in_width+rib, rib, in_height], anchor=-x-y-z);
        translated(in_x/3*x, n=[1,2]) box([rib, fan_y, in_height], anchor=-x-y-z);
      }
      // 底部内加强肋
      translated(fan_y/2*y+wall_thickness*z) rotated(45*x) box([in_x, rib, rib], anchor=-x);
      // 打印辅助，需要去除
      // translated(z, n=[0, wall_thickness])
      translated((fan_y + fan_d/3)*y) box([in_x, fan_d, 0.8], anchor=-x-y-z);
    }
    hull() {
      box([in_x, in_thickness, in_height+rib], anchor=-x-y-z);
      translated(fan_x*x + fan_y*y) rod(d=fan_d+rib*2, h=fan_z+rib, anchor=bottom);
    }
  }
}

// 螺丝安装板
module B() {
  translated(x, n=[0, in_x])
  differed("hole", "not(hole)") {
    box([in_edge*2, in_thickness, in_height], anchor=-y-z);
    translated(z, n=[in_edge, in_edge+in_z]) orient(y) rod(d=4.5, h=in_thickness, anchor=bottom, $class="hole");
  }
  translated(in_edge*x + in_height*z) box([in_width, in_thickness*2, rib*2], anchor=-x-y+z);
}

// to fit printing area for delta printer
rotate([90,0,0]) {
  A();
  B();
}
