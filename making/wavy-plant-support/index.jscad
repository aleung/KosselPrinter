// configuration begin
const R = 90;
const WAVE_LENGTH = 16;
const WAVE_HEIGHT = 10;
const SEGMENTS = 2;
const SEGMENT_ARC_DEGREES = 60;
const WIDTH = 2;
const HEIGHT = 2;
const HOLE_D = 5;
// configuration end


function curve(arcBegin, arcEnd) {
  const period = WAVE_LENGTH / (R * Math.PI);
  const ext = (arcEnd - arcBegin) % (period * Math.PI) / 2;
  return (rad) => {
    if (rad < (arcBegin + ext) || rad > (arcEnd - ext)) {
      return R;
    } else {
      return R + WAVE_HEIGHT / 2 - Math.cos(Math.sin((rad - arcBegin - ext) / period) * Math.PI) * WAVE_HEIGHT / 2;
    }
  }
}

function polarToXY([r, rad]) {
  return [r * Math.cos(rad), r * Math.sin(rad)];
}

function degToRad(deg) {
  return deg * Math.PI / 180;
}

function range(n) {
  return Array.from(Array(n + 1).keys());
}

function toPath(curve, arcBegin, arcEnd) {
  const f = curve(degToRad(arcBegin), degToRad(arcEnd));
  return range(arcEnd - arcBegin)
    .map(a => a + arcBegin)
    .map(degToRad)
    .map(a => [f(a), a])
    .map(polarToXY);
}

function jointCylinder(r, deg) {
  return translate(polarToXY([R, degToRad(deg)]), cylinder({ r, h: HEIGHT }));
}

function main() {
  return difference(
    union(
      range(SEGMENTS)
        .map(n => SEGMENT_ARC_DEGREES * n)
        .map(degrees => jointCylinder(HOLE_D / 2 + WIDTH, degrees))
        .concat(
          range(SEGMENTS - 1)
            .map(n => rectangular_extrude(
              toPath(curve, SEGMENT_ARC_DEGREES * n, SEGMENT_ARC_DEGREES * (n + 1)), { w: WIDTH, h: HEIGHT })
            )
        )
    ),
    union(
      range(SEGMENTS)
        .map(n => SEGMENT_ARC_DEGREES * n)
        .map(degrees => jointCylinder(HOLE_D / 2, degrees))
    )
  );
}
