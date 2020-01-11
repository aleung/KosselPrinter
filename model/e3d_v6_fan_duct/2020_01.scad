// Relativity SCAD library
// https://raw.githubusercontent.com/aleung/relativity.scad/master/relativity.scad
include <../../lib/relativity.scad/relativity.scad>

fan_fixer_thickness = 3.5;
fan_tilt = 20;
fan_vertical_offset = 0;  // x axis in this model
seperator_offset = 7;     // e3d heatsink flue and nozzle flue seperator position
bolt_pillar_lenght = 5;
outlet_tilt = fan_tilt+90;
outlet_offset_vertical = -2;    // adjust then check the position
outlet_offset_horizontal = 4;
outlet_size = [7, 17];

nozzle_z = 23.5;          // vertical distant from nozzle tip to e3d heat sink
nozzle_tip = 6;           // nozzle tip length

D_M3 = 3.3; 
D_M3_BOLT = 6.6;
$fn=30;

module body() {
  differed("cut", "not(cut)", "notcut") {
    hull() {
      minkowski() {
        box([32, 32, fan_fixer_thickness], anchor=-z);
        rod(r=4, h=0.001);
      }
      translated(fan_fixer_thickness*z-(fan_vertical_offset+20)*x) 
        rotated(-fan_tilt*y) box([30.5, 30.5, 0.01], anchor=-x);
    }

    // 风扇卡扣
    mirrored(y) hulled("hull") {
      translated(fan_fixer_thickness*z-(fan_vertical_offset+20)*x+10*y)
        rotated(-fan_tilt*y) box([2,5,2], anchor=x-z)
          align(-z) box([$parent_size.x, $parent_size.y, 0.1], anchor=z, $class="hull");
      translated(-20*x+10*y) box([1, 5, 1], anchor=-x-z, $class="hull");
    }

    // 风扇螺丝孔
    mirrored(x) mirrored(y)
      translated(16*x+16*y-0.002*z) rod(d=D_M3, h=2, anchor=bottom, $class="cut")
        align(top) rotated(20*z) rod(d=D_M3_BOLT, h=4, anchor=bottom, $fn=6);
    mirrored(y) translated(20*x+20*y+(fan_fixer_thickness+0.6)*z) 
      rod(r=D_M3_BOLT/2+4*1.414-0.4, h=6, anchor=bottom, $class="cut");

    // E3D 散热片风道
    class("cut") hulled("hull") {
      class("hull") difference() {
        rod(d=37, h=0.02);
        translated((seperator_offset-0.5)*x) box([40, 40, 0.02], anchor=-x);
      } 
      translated(fan_fixer_thickness*z-(fan_vertical_offset+20)*x) 
        rotated(-fan_tilt*y) box([30.5, 30.5, 0.01], anchor=-x)
          align(top) rod(d=27, h=0.01, $class="hull");
    }  

    // 喷嘴风道
    hull() {
      difference() {
        rod(d=40, h=0.01);
        translated((seperator_offset-2)*x) box([40, 40, 0.01], anchor=+x);
      } 
      rotated(-outlet_tilt*y) 
        translated((15-outlet_offset_horizontal)*x+(outlet_offset_vertical-25)*z) 
          box([outlet_size.x, outlet_size.y, 0.01]);
    }  
    class("cut") hull() {
      difference() {
        rod(d=37, h=0.02);
        translated((seperator_offset+0.5)*x) box([40, 40, 0.02], anchor=+x);
      } 
      rotated(-outlet_tilt*y) 
        translated((15-outlet_offset_horizontal)*x+(outlet_offset_vertical-25)*z) 
          box([outlet_size.x-2, outlet_size.y-2, 0.02]);
    }  

    translated(fan_fixer_thickness*z-(fan_vertical_offset+20)*x) 
      rotated(-fan_tilt*y) box([30.5, 30.5, 0], anchor=-x) {
        class("e3d") children();
        mirrored(y) translated(12*x+12*y) {
          rod(d=6, h=50, anchor=top, $class="cut");
          class("notcut") difference() {
            rod(d=6, h=bolt_pillar_lenght, anchor=top);
            rod(d=3.2, h=50);
          }
        }
      }
  }

}

module e3d() {
  differed("cut", "not(cut)", "notcut")
    box([30, 30, 15], anchor=-z) {
      align(x+z)
        orient(x) rod(d=22, h=27, anchor=top, $class="notcut") {
          align(top) rod(d=8, h=nozzle_z-nozzle_tip, anchor=bottom, $fn=6)
            align(top) {
              translated(5*x-3*z) box([20, 15, 11.5], anchor=x+z);   // heater block
              hulled("hull")
                rod(d=4, h=0.01, anchor=bottom, $fn=18, $class="hull")
                  align(bottom) rod(d=0.5, h=nozzle_tip, anchor=bottom)              // nozzle tip
                    align(top) rod(r=10, h=1, anchor=bottom, $class="notcut")        // bed
                      align(bottom) rod(r=50, h=1, anchor=bottom);
            }
          align(bottom) rod(d=12, h=10, anchor=top);
        }
      align(-z) translated(-z) rod(d=27, h=17, anchor=-z, $class="cut");
    }
}

body() {
  attach("e3d") %e3d();
};
