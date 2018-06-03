// 电脑桌电源插座支撑平台

const x1 = 45;
const x2 = 21;
const x3 = 8;
const y = 30;
const h = 25;
const thickness = 3;


function main() {
  const triangle = linear_extrude(
    { height: thickness },
    CAG.fromPoints([[0, 0], [x1, 0], [x1 - thickness, h]])
  ).rotateX(90);
  return union([
    cube([x1 + x2 + x3, y, -thickness]),
    cube([-thickness, y, h]).translate([x1, 0, 0]),
    cube([thickness, y, h]).translate([x1 + x2, 0, 0]),
    cube([x3, thickness, h]).translate([x1 + x2, 0, 0]),
    cube([x3, -thickness, h]).translate([x1 + x2, y, 0]),
    triangle.translate([0, thickness, 0]),
    triangle.translate([0, y, 0]),
  ]);
}
