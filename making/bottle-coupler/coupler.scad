include <../../lib/helix_extrude.scad>

h = 10;
$fn = 60;

// 30/25 bottle
threadOutD = 30.3 + 0.3;
threadInD = 28.0 + 0.3;
pitch = 3.0;

module thread(height, pitch, inOrOut=1 /* in=-1, out=1 */, direction=1 /* normal=1, reversed=-1*/, starts=1) {
  rotateAngle = 360 * height / pitch / starts;
  threadDepth = (threadOutD - threadInD) / 2;
  intersection() {
    translate([0,0,-pitch])
      for (start=[0:(360/starts):360]) rotate([0, 0, start])
        helix_extrude(height = height + pitch, angle = rotateAngle*(direction>0?1:-1))
          translate([(inOrOut>0?threadInD:-threadOutD)/2, 0, 0])
            helixPolygon(0.8, 2, threadDepth);
    cylinder(d=threadOutD, h=height);
  }
}

module half(direction) {
  union() {
    difference() {
      cylinder(d=threadOutD+4,h=h);
      union() {
        cylinder(d=25, h=0.5);
        translate([0,0,0.5]) cylinder(d1=25, d2=threadOutD, h=1.5);
        translate([0,0,2]) cylinder(d=threadOutD,h=h);
      }
    }
    thread(h-1, pitch, inOrOut=-1, direction=direction, starts=3);
  }
}

half(1);
mirror([0,0,1]) half(-1);
