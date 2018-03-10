const resolution = 120;

function spherical_cylinder(h, d, R) {
  const sphereZ = h - sqrt(R * R - d * d / 4)
  return CSG.sphere({ radius: R, center: [0, 0, sphereZ], resolution })
    .subtract(CSG.cylinder({ radius: R * 2, start: [0, 0, -2 * R], end: [0, 0, h] }))
    .union(CSG.cylinder({ radius: d / 2, start: [0, 0, 0], end: [0, 0, h], resolution }));
}

function blade(r1, r2, h, a, n) {
  return square({ size: [r2 - r1, h] }).translate([r1, 0]).rotateExtrude({ angle: a, resolution });
}

function ribs() {
  const rib = CSG.cube({
    corner1: [0, -2, 0],
    corner2: [35, 2, 20]
  });
  return union([
    rib.rotateZ(50),
    rib.rotateZ(170),
    rib.rotateZ(290)
  ]);
}

function main() {
  const h1 = 6.5;
  const h2 = 5;
  const t = 3;
  const blade1 = blade(34, 40, 1.5, 25);
  const blade2 = blade(104 / 2, 105 / 2 + 1.5, 2, 25).translate([0, 0, h1 + h2 - 2]);
  const outsideSphericalCyliner = spherical_cylinder(h1 + t, 70, 60);


  return union([
    outsideSphericalCyliner.subtract(spherical_cylinder(h1, 64, 60)),
    ribs().intersect(outsideSphericalCyliner),
    blade1,
    blade1.rotateZ(120),
    blade1.rotateZ(-120),
    CSG.cylinder({ start: [0, 0, h1], end: [0, 0, h1 + h2], radius: 105 / 2, resolution })
      .subtract(CSG.cylinder({ start: [0, 0, h1 + t], end: [0, 0, h1 + h2], radius: 95 / 2, resolution }))
      .subtract(CSG.cylinder({ start: [0, 0, h1], end: [0, 0, h1 + t], radius: 64 / 2, resolution })),
    blade2,
    blade2.rotateZ(120),
    blade2.rotateZ(-120),
  ])
    // .intersect(CSG.cube({ corner1: [-100, -10, 0], corner2: [100, 10, 20] }));
}
