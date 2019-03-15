const AC = 105;
const BC = 13;
const AB = AC - BC;

const JK = 9;
const KL = 13;
const JM = 61;
const LM = JM - JK - KL;

const HA = 2;
const HB = 12;
const HC = 13;
const HD = 15 + 3;
const HE = 22 + 3;
const HF = 31 + 3;

const SURFACE = 1.5;
const WALL = 2;

function bolt(l) {
  const A = 3;
  const B = 4;
  const W = 3 * 2 + B + 2;
  const H = 5;

  const partA = () => cube({ size: [A, l, H] }).translate([-W / 2, 0, 0]);

  const partB = () => {
    return union(
      cube({ size: [B, l + 3, 1.5], center: [true, false, false] }).translate([0, 0, 3.5]),
      cube({ size: [B, 2, 3], center: [true, false, false] }).translate([0, l + 1, 3.6])
    );
  }

  const rib = () => cube({ size: [2.5, -16, H] }).translate([-W / 2, 0, 0]);

  const partC = () => {
    return union(
      cube({ size: [W, -4, H], center: [true, false, false] }),
      cube({ size: [W, -16, 3], center: [true, false, false] }),
      rib(),
      rib().mirroredX()
    ).subtract(cylinder({ d: 3.4, h: H, center: [true, true, false] }).translate([0, -10, 0]));
  }

  return union(
    partA(),
    partA().mirroredX(),
    partB(),
    partC()
  );
}

function cleat(w, h, l) {
  const gap = 0.6;
  return cube({ size: [w + gap + 3 * 2, h + gap + 3, l], center: [true, false, false] })
    .subtract(cube({ size: [w + gap, h + gap, l], center: [true, false, false] }))
    .mirroredY();
}


function partA() {
  const wallHeight = SURFACE + HA + HB + 2;

  const leftWall = () => {
    const usbHoleHeight = wallHeight - HA - SURFACE;
    return cube({ size: [WALL, JM + WALL * 2, wallHeight] }).translate([-WALL, -WALL, 0])
      .subtract(cube({ size: [WALL, KL, usbHoleHeight] }).translate([-WALL, LM, wallHeight - usbHoleHeight]));
  };

  const rightWall = () => {
    const rightWallHeight = SURFACE + HA + HB + HC;
    return union(
      cube({ size: [WALL, JM + WALL * 2, rightWallHeight] }).translate([AC, -WALL, 0]),
      cube({ size: [BC, WALL, rightWallHeight] }).translate([AB, -WALL, 0]),
      cube({ size: [BC, WALL, rightWallHeight] }).translate([AB, JM, 0])
    );
  }

  const longWall = (y) => cube({ size: [AC, WALL, wallHeight] }).translate([0, y, 0]);

  const rib = () => cube({ size: [90, WALL, HA] }).translate([0, 30, SURFACE]);

  return union(
    cube({ size: [AC, JM, SURFACE] }),
    leftWall(),
    rightWall(),
    longWall(-WALL),
    longWall(JM),
    rib(),
    cleat(12, 5, 15).translate([10, -WALL, 0]),
    cleat(12, 5, 15).translate([AC - 10, -WALL, 0]),
    cube({ size: [4, JM, HA] }).translate([0, 0, SURFACE]),
    cube({ size: [2, JM, HA] }).translate([AC - 2, 0, SURFACE]),
    cube({ size: [AC, 5, HA] }).translate([0, 0, SURFACE])
  );
}

function partB() {
  const leftPartWidth = 27;
  const rightPartWidth = 75;
  const topOffsetY = 28;

  const leftPart = () => {
    return union(
      cube({ size: [leftPartWidth, JM + WALL, SURFACE] }).translate([0, 0, HF]),
      cube({ size: [leftPartWidth, WALL, HF + SURFACE] }).translate([0, -WALL, 0]),
      cube({ size: [20, WALL, HF] }).translate([0, JM, 0]),
      cube({ size: [WALL, JM, HF - HC] }).translate([12, 0, HC]),
      cube({ size: [1, topOffsetY + 1, 30] }).translate([leftPartWidth - 1, 0, HF - 30])
    );
  };

  const fanBoard = () => {
    const length = 35;
    const centerX = 60 - leftPartWidth;
    const centerY = length / 2;
    return union(
      cube({ size: [rightPartWidth, length, SURFACE] }),
      cylinder({ d: 41, h: 2 }).translate([centerX, centerY, SURFACE])
    ).subtract(union(
      cylinder({ d: 29, h: 5 }).translate([centerX, centerY, 0]),
      cylinder({ d: 3.4, h: 5 }).translate([centerX - 12.1, centerY - 12.1, 0]),
      cylinder({ d: 3.4, h: 5 }).translate([centerX - 12.1, centerY + 12.1, 0]),
      cylinder({ d: 3.4, h: 5 }).translate([centerX + 12.1, centerY - 12.1, 0]),
      cylinder({ d: 3.4, h: 5 }).translate([centerX + 12.1, centerY + 12.1, 0])
    )).rotateX(34)
      .translate([leftPartWidth, -1.5, HC + 1.8])
      .intersect(cube({ size: [rightPartWidth, JM, HF] }).translate([leftPartWidth, -WALL, SURFACE]));
  };

  const rightPart = () => {
    const rightWallX = 95;
    return union(
      fanBoard(),
      cube({ size: [rightPartWidth, JM - topOffsetY + WALL + 1.5, SURFACE] })
        .translate([leftPartWidth, topOffsetY - 1.5, HF]),
      cube({ size: [90 - leftPartWidth, WALL, HC + 2.5] }).translate([leftPartWidth, -WALL, 0])
        .subtract(cylinder({ d: 6, h: WALL }).rotateX(-90).translate([38, -WALL, 7])),
      cube({ size: [WALL, JM - topOffsetY, 30] }).translate([rightWallX, topOffsetY, HF - 30]),
      cube({ size: [rightWallX - leftPartWidth, 1, HF - HE] }).translate([leftPartWidth, topOffsetY, HE]),
      cube({ size: [10, 1, HF - HC] }).translate([48, topOffsetY, HC]),
      cube({ size: [rightWallX - 68, 1, HF - HC] }).translate([68, topOffsetY, HC]),
      cube({ size: [1, 5, HF - HC] }).translate([75, topOffsetY, HC]),
      polygon([[3, 0], [17, 0], [24, 10], [3, 10]]).extrude().rotateY(-90).translate([90, 0, 0]),
      polygon([[22, 10], [24, 10], [HF, topOffsetY], [22, topOffsetY]]).extrude().rotateY(-90).translate([90, 0, 0]),
      cube({ size: [30, WALL, HF] }).translate([45, JM, 0]),
      cube({ size: [WALL, 5, 30] }).translate([72, JM - 5, HF - 30])
    );
  };

  const clip = (h) => {
    return union(
      cube({ size: [10, 2, -h - 1], center: [true, false, false] }),
      cube({ size: [10, 1.8, 5], center: [true, false, false] }).rotateX(-23),
      cube({ size: [10, 2, -4], center: [true, false, false] }).rotateX(70).translate([0, 0, -h - 1])
    ).translate([0, -2, 0]);
  }

  return union(
    cube({ size: [leftPartWidth + rightPartWidth, WALL, 2] }).translate([0, JM, HF - 2]),
    leftPart(),
    rightPart(),
    clip(25).translate([25, -WALL, 0]),
    clip(25).translate([70, -WALL, 0]),
    clip(18).mirroredY().translate([15, JM + WALL, 0]),
    clip(18).mirroredY().translate([70, JM + WALL, 0])
  );
}

function main() {
  return union(
    partA().setColor(0.2, 0.8, 0.4),
    partB().translate([0, 0, 17.5]),
    bolt(15).translate([-15, 0, 0])
  )
    // for debug
    // .intersect(cube([32, 100, 152.5]).translate([9, -30, -100]))
    ;
}
