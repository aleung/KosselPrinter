H1 = 15;

module A() {
  translate([0, 5, 0]) union() {
    mirror([0,1,0]) cube([13, 5, H1]);
    translate([13, 0, 0]) intersection() {
      cylinder(h=H1, r=5);
      mirror([0,1,0]) cube([5, 5, H1]);
    };
    cube([3, 15, H1]);
    translate([3, 0, 0]) intersection() {
      cylinder(h=H1, r=15);
      cube([15, 15, H1]);
    };
  }
}

module B() {
  difference() {
    mirror([0, 0, 1]) translate([-5, 1, 0]) cube([10, 4, 15]);
    translate([0,0,-10]) rotate([-90, 0, 0]) cylinder(h=6, d=3.4, $fn=12);
    translate([0,3,-10]) rotate([-90, 0, 0]) cylinder(h=6, d=6.8, $fn=6);
  }
}

module C() {
  translate([20,0,0]) rotate([90,0,-90]) linear_extrude(height=2) polygon([[20,-4], [20,0], [0,0], [0,-16], [2,-16]]);
}

module FRONT() {
  difference() {
    union() {
      C();
      mirror([1,0,0]) C();
      translate([-20,-2,-16]) cube([40,2,16]);
      translate([-20,-15,-3]) cube([40,15,1.5]);
    };
    translate([-20,-10,-1.5]) cube([40,10,2]);
    hull() {
      translate([0,0,-6]) rotate([90, 0, 0]) cylinder(h=6, d=3.4, $fn=12);
      translate([0,0,-12]) rotate([90, 0, 0]) cylinder(h=6, d=3.4, $fn=12);
    }
  }
}

module BACK() {
  difference() {
    union() {
      A();
      mirror([1,0,0]) A();
      B();
    };
    translate([-13,-1,0]) cube([26, 2, H1+1]);
  }
}

union() {
  FRONT();
  BACK();
}
