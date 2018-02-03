corner_r = 4;
fan_fixer_d = 3;
bolt_pillar_lenght = 5;
D_M3 = 3.3; 
D_M3_BOLT = 6.6;

$fn=40; // set to 40 in final output


difference() {
  union() {
    difference() {
      union() {
        main_body(fan_fixer_d);
        color("blue") hotend_duct(fan_fixer_d); 
      }
      e3d_v6_flue(fan_fixer_d);
      hotend_flue(fan_fixer_d);
    }
    color("red") e3d_v6_duct_bolt_pillar(fan_fixer_d, bolt_pillar_lenght);
  }
  e3d_v6_duct_bolt_hole(fan_fixer_d, bolt_pillar_lenght);
}

//color("white") e3d_v6_and_fan_duct(fan_fixer_d);  // remark it in final output


// 风扇座, d-最小厚度
module main_body(d) {
  difference() {
    union() {
        translate([corner_r, corner_r, 0]) minkowski() {
          cube([40-corner_r*2, 40-corner_r*2, 20]);
          cylinder(r=corner_r, 20);        
        }
        // 卡扣
        translate([-4, 15, 0]) cube([4, 10, 5]);
    }
    
    // 削去多余部分
    rotate(a=-30, v=[0,1,0]) translate([0, 0, d]) cube([80, 40, 50]);
    translate([40, 0, d+1]) rotate(a=-45, v=[0,1,0]) cube([20, 40, 40]);

    translate([0, 0, d+1]) rotate([70,0,0]) cube([40, 20, 20]);
    translate([0, 40, d+1]) rotate([20,0,0]) cube([40, 20, 20]);
    
    // 螺丝孔
    translate([4,4,-0.1]) cylinder(h=6.1, d=D_M3);
    translate([36,4,-0.1]) cylinder(h=6.1, d=D_M3);
    translate([4,36,-0.1]) cylinder(h=6.1, d=D_M3);
    translate([36,36,-0.1]) cylinder(h=6.1, d=D_M3);
    
    translate([4,4,2]) rotate([0,0,6.5]) cylinder(h=20, d=D_M3_BOLT, $fn=6);
    translate([36,4,2]) rotate([0,0,-6.5]) cylinder(h=20, d=D_M3_BOLT, $fn=6);
    translate([4,36,2]) rotate([0,0,-6.5]) cylinder(h=20, d=D_M3_BOLT, $fn=6);
    translate([36,36,2]) rotate([0,0,6.5]) cylinder(h=20, d=D_M3_BOLT, $fn=6);
    
    translate([38, 2, 4]) cylinder(r=6, h=20);
    translate([38, 38, 4]) cylinder(r=6, h=20);
  }

}

module e3d_v6_and_fan_duct(d) {
  rotate(a=-30, v=[0,1,0]) translate([0, 5, d]) {
    difference() {
      cube([30, 30, 15]);
      translate([15, 15, -0.1]) cylinder(d=27, 15);    
    }
    translate([0, 15, 15]) rotate(a=90, v=[0,1,0]) {
      cylinder(d=22, 26);
      translate([0, 0, -5]) cylinder(d=8, 47);
      translate([0, 0, 40]) cylinder(d1=8, d2=0, 4);
      translate([-15, -7.5, 30]) cube([20, 15, 10]);
    }
  }
}

module e3d_v6_duct_bolt_hole(d, length) {
  rotate(a=-30, v=[0,1,0]) translate([0, 5, d]) {
      translate([27, 3, -length-0.5]) cylinder(r=1.6, length+1);    
      translate([27, 27, -length-0.5]) cylinder(r=1.6, length+1);    
      translate([27, 3, -20-length]) cylinder(r=3.3, 20);    
      translate([27, 27, -20-length]) cylinder(r=3.3, 20);    
  }
}

module e3d_v6_duct_bolt_pillar(d, length) {
  rotate(a=-30, v=[0,1,0]) translate([0, 5, d])  {
      translate([27, 3, -length]) cylinder(r=3.3, length);    
      translate([27, 27, -length]) cylinder(r=3.3, length);    
  }
}


// E3D V6 散热风道
module e3d_v6_flue(d) {
  hull() {
    rotate(a=-30, v=[0,1,0]) translate([15, 20, d]) cylinder(d=27, 1);    
    difference() {
      translate([20, 20, -0.1]) cylinder(d=37, 1);
      translate([19.5, 0, -0.1]) cube([30, 40, 1]);
    }
  }
}

module hotend_duct(d) {
    hull() {
        translate([27.5, 9, 28]) rotate(a=40, v=[0,1,0]) cube([7, 22, 1]);
        translate([28, 20, 12+3]) rotate([0, 45, 0]) difference() {
           cylinder(d=31, 1);
           translate([-19, -20, 0]) cube([15, 40, 1]);
        }
    }
}

// 挤出端散热风道
module hotend_flue(d) {
    hull() {
        translate([29,11, 28]) rotate(a=40, v=[0,1,0]) cube([4, 18, 1]);
        difference() {
          translate([20, 20, -0.1]) cylinder(d=37, 1);
          translate([0, 0, -0.1]) cube([20.5, 40, 1]);
        }
    }
}
