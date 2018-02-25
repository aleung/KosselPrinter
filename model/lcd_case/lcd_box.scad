$fn = 12;

AD = 150+1;
BC = 98;
CD = 39;
DE = 13;
AC = AD - CD;
AB = AC - BC;
AE = AD - DE;

JK = 20;
JL = 30;
JM = 47;
JN = 55;
NP = 8.4;
JP = JN + NP;
LP = JP - JL;
KL = JL - JK;
KP = JP - JK;
LN = JN - JL;
MP = JP - JM;

HU = 10.5;
HL = 6.5;
HB = 5;
HS = 4;
H = HU + HL;
HT = HU - HS;

surface = 1.5;
wall = 2;

// explode = true;
explode = false;

detachable_stand = true;

offset_y = LP;
// offset_y = explode ? 70 : LP;
offset_z = explode ? 60 : H+surface;


intersection() {
  union() {
    translate([0, offset_y, offset_z]) part_A();
    translate([0, 0, offset_z]) part_B();
    part_C();
    translate([AD+wall, JP+wall, explode ? -20 : 0]) color("blue") stand();
  }
  // debug:
  // translate([AC-10, -3, 40]) cube([18, 20, 100]);
}


module part_A() {
  difference() {
    union() {
      // surface
      difference() {
        cube([AD+wall, JL+wall, surface]);
        translate([AE, 0, -0.1]) cylinder(d=18, h=3, $fn=30);
        translate([AE, JL-10, -0.1]) cylinder(d=5, h=3);
        translate([AB, 0, -0.1]) cube([BC, JL-13, 3]);
      }  
      // wall
      // translate([-wall, JL, -HU]) cube([AD+wall*2, wall, HU+surface]);
      translate([-wall, 0, -HU]) cube([wall, JL+wall, HU+surface]);
      // translate([AD, 0, -HU]) cube([wall, JL, HU+surface]);
      // rib
      translate([AC+5, 0, -HU]) cube([wall, JL, HU]);
      translate([AC-45, JL-13, -HT]) cube([wall, 13, HT]);
      translate([AC-45, JL-13, -HT]) cube([5, wall, HT]);
      
      // translate([AD-2.5, JL-2.5, -HU]) mirror([1,0,0]) screw_chimney(HU+surface);
      translate([2.5, JL-2.5, -HU]) screw_chimney(HU+surface);
    }
    // hole
    // translate([AD-2.5, JL-2.5, 2-HU]) mirror([1,0,0]) hole(HU-2+surface+0.1);
    translate([2.5, JL-2.5, 2-HU]) hole(HU-2+surface+6+0.1);

    translate([-wall, JL, -HU]) cube([AD+wall*2, wall, HU]);
  }
}

module part_B() {
  difference() {
    union() {
      // surface
      difference() {
        cube([AD+wall, LP, surface]);
        translate([AE, LP, -0.1]) cylinder(d=18, h=3, $fn=30);
        translate([AB, NP+wall, -0.1]) cube([BC, LN, 3]);
        // button
        difference() {
          union() {
            translate([AE, JP-47, -1]) cylinder(d=7, h=3);
            translate([AE-18, JP-47-7/2, -1]) cube([18, 7, 3]);      
          }
          translate([AE-18, JP-47-4/2, -1]) cube([18, 4, 3]);
        }
        translate([AE-1, JP-47, surface-0.5]) scale([1, 1.3]) cylinder(d=9, h=0.6);
        translate([AE-5, NP-2, surface-0.5]) linear_extrude(height = 0.5) text("STOP", size=3);
      }
      // button
      hull() {
        translate([AE, JP-47, -6]) cylinder(d=4, h=6+surface);
        translate([AE-2, JP-47, -6]) cylinder(d=4, h=6+surface);
      }
      // wall
      difference() {
        translate([-wall, -wall, -HU]) cube([AD+wall*2, wall, HU+surface]);
        translate([AB, -wall-0.1, -HU]) cube([BC, wall+0.2, HS]);
      }
      translate([-wall, -wall,-HU]) cube([wall, LP+wall, HU+surface]);
      // translate([AD, -wall, -HU]) cube([wall, LP+wall, HU+surface]);
      // rib
      translate([AC+5, 0, -HU]) cube([wall, LP, HU]);
      translate([AC-45, 0, -HT]) cube([wall, NP, HT]);

      translate([AC-3, JP-60.5, -HT]) screw_chimney(HT+surface);
      translate([AB+3, JP-60.5, -HT]) mirror([1,0,0]) screw_chimney(HT+surface);
    }
    // hole
    translate([AC-3, JP-60.5, -4]) hole(surface+6+0.1);
    translate([AB+3, JP-60.5, -4]) mirror([1,0,0]) hole(surface+6+0.1);    
  }
}

module part_C() {
  difference() {
    union() {
      // surface
      difference() {
        cube([AD, JP, surface]);
        translate([45, JP-20-13, -0.1]) cube([AD-45-60, 13, 3]);
        translate([8, JP-7-10, -0.1]) cube([10, 10, 3]);
      }
      // wall
      translate([-wall, -wall, 0]) cube([AD+wall*2, wall, HL+surface]);
      translate([-wall, JP, 0]) cube([AD+wall*2, wall, H+surface]);
      translate([-wall, 0, 0]) cube([wall, MP, HL+surface]);
      translate([-wall, KP, 0]) cube([wall, JK, HL+surface]);
      translate([AD, 0, 0]) cube([wall, JP, H+surface]);
      translate([AB+1, -wall, surface]) cube([BC-2, wall, HB+HS]);
      // rib
      translate([AC+5, 0, surface]) cube([wall, JP, HB]);
      translate([AD-3, LP+5, surface]) cube([3, 4, HB]);
      translate([45, JP-35, surface]) cube([45, wall, HB]);
      translate([0, 0, surface]) cube([3, MP, HB]);

      // translate([AD-2.5, JP-2.5, 0]) mirror([1,0,0]) screw_chimney(HB+surface);
      translate([2.5, JP-2.5, 0]) screw_chimney(HB+surface);
      // translate([AD-2.5, JP-55+2.5, 0]) mirror([1,0,0]) screw_chimney(HB+surface);
      // translate([2.5, JP-55+2.5, 0]) screw_chimney(HB+surface);
      translate([AC-3, JP-60.5, 0]) screw_chimney(HB+HS+surface);
      translate([AB+3, JP-60.5, 0]) mirror([1,0,0]) screw_chimney(HB+HS+surface);
    }
    // hole
    // translate([AD-2.5, JP-2.5, -4]) mirror([1,0,0]) hole(surface+6+0.1);
    translate([2.5, JP-2.5, -4]) hole(surface+6+0.1);
    translate([AC-3, JP-60.5, -0.1]) hole(HB+HS-2+0.1);
    translate([AB+3, JP-60.5, -0.1]) mirror([1,0,0]) hole(HB+HS-2+0.1);

    translate([wall+AD-5, wall+JP-10, 0]) cylinder(d=3.4, h=4);
    translate([wall+AD-5, wall+JP-30, 0]) cylinder(d=3.4, h=4);
    
  }
  translate([AD+wall,JP+wall,H+wall*2-10]) mount();
  translate([-wall, JP+wall, H+wall*2-10]) mirror([1, 0, 0]) mount();
}

module screw_chimney(h) {
  color("red") difference() {
    hull() {
      cylinder(d=8, h=h);
      translate([2, 0, 0]) cylinder(d=8, h=h);
    }
    hull() {
      translate([0, 0, -0.1]) cylinder(d=3.4, h=h+0.2);
      translate([2, 0, -0.1]) cylinder(d=3.4, h=h+0.2);
    }
  }
}

module hole(h) {
  hull() {
    cylinder(d=6.5, h=h);
    translate([2, 0, 0]) cylinder(d=6.5, h=h);
  }
}

module stand() {
  difference() {
    rotate([0,-90,0]) linear_extrude(10) polygon(points=[[0,-35], [0,0], [-20, 0]]);
    translate([-5, -10, -10]) cylinder(d=2, h=10.1);
  }
  translate([-5, -30, 0]) cylinder(d=2.8, h=4);
}

module mount() {
  translate([0, -3, -6]) difference() {
    cube([8, 3, 12]);
    translate([4, -0.1, 6]) rotate([-90, 0, 0]) cylinder(d=3.4, h=4);
  }
  translate([0, -3, -6]) linear_extrude(2) polygon(points=[[0,0], [8,0], [0, -10]]);
}
