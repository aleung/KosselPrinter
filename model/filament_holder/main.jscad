function triangleFrame2d() {
  return polygon([[-50, 0], [50, 0], [10, 120], [-10, 120]])
    .subtract(polygon([[-36, 10], [36, 10], [5, 105], [-5, 105]]))
}

function frameMortise() {
  return union(
    squareBar(6, 0),
    trapezoidBar(2.5, 0)
  );
}

function triangleFrame() {
  return linear_extrude({ height: 6 }, triangleFrame2d())
    .subtract(cylinder({ d: 10, h: 6, fn: 18 }).translate([0, 118]))
    .subtract(frameMortise().translate([-42, 0, 0]).scale([1.02, 1.03, 1]))
    .subtract(frameMortise().translate([42, 0, 0]).scale([1.02, 1.03, 1]))
}


function trapezoidBar(height, offsetZ) {
  return linear_extrude({ height }, polygon([[-5, 0], [5, 0], [2.5, 5], [-2.5, 5]]))
    .translate([0, 0, offsetZ]);
}

function squareBar(height, offsetZ) {
  return linear_extrude({ height }, square(5).translate([-2.5, 0])).translate([0, 0, offsetZ]);
}

function bar() {
  return union(
    trapezoidBar(2, 0),
    squareBar(4, 2),
    trapezoidBar(70, 6),
    squareBar(4, 76),
    trapezoidBar(2, 80)
  );
}

function main() {
  return union(
    triangleFrame(),
    // bar().translate([42, -10, 0])
  )
}