/* Convenience functions for more-readable translations and rotations.
  Where relative directions like "left" and "right" are used,
  they assume you're looking from the Front view in OpenSCAD (Ctrl+8), 
  which is looking down the Y axis with X pointing right and Z to the top of the screen.
*/

include <dfm.scad>

module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ 
  translate([x,y,z])
    rotate([rx,ry,rz]) 
      children(); 
}

module moveUp(x) {
  translate([0, 0, x])
    children();
}

module moveDown(x) {
  translate([0, 0, -x])
    children();
}

module moveLeft(x) {
  translate([-x, 0, 0])
    children();
}

module moveRight(x) {
  translate([x, 0, 0])
    children();
}

module moveBack(x) {
  translate([0, x, 0])
    children();
}

module moveForward(x) {
  translate([0, -x, 0])
    children();
}

module nudgeLeft() {
  moveLeft(EPSILON)
    children();
}
module nudgeRight() {
  moveRight(EPSILON)
    children();
}
module nudgeBack() {
  moveBack(EPSILON)
    children();
}
module nudgeForward() {
  moveForward(EPSILON)
    children();
}
module nudgeUp() {
  moveUp(EPSILON)
    children();
}
module nudgeDown() {
  moveDown(EPSILON)
    children();
}

module flipOver() {
  rotate([180, 0, 0])
    children();
}

module turnAround() {
  rotate([0, 0, 180])
    children();
}

module spin(angle) {
  rotate([0, 0, angle])
    children();
}

// I'm forever modeling things on the X-Y plane and then flipping them vertically around X.
module tipUp(angle=90) {
  rotate([angle, 0, 0])
    children();
}

module invert() {
  mirror([0, 0, 1])
    children();
}

// Trim functions: remove the area indicated by the name.
// Specifying the target size improves OpenSCAD display.
// Add an offset to move the trim line towards what's being trimmed;
// e.g. trimLower(offset=5) trims away from Z=-5 in the -Z direction.

module trimLower(size=HUGE, offset=0) {
  difference() {
    union() {
      children();
    }
    moveDown(size/2 + offset)
      cube([size, size, size], center=true);
  }
}

module trimUpper(size=HUGE, offset=0) {
  difference() {
    union() {
      children();
    }
    moveUp(size/2 + offset)
      cube([size, size, size], center=true);
  }
}

module trimRight(size=HUGE, offset=0) {
  difference() {
    union() {
      children();
    }
    moveRight(size/2 + offset)
      cube([size, size, size], center=true);
  }
}

module trimLeft(size=HUGE, offset=0) {
  difference() {
    union() {
      children();
    }
    moveLeft(size/2 + offset)
      cube([size, size, size], center=true);
  }
}

// Trims both right and left sides with the given offset.
// (Using an offset of 0 makes no sense - it would include nothing - so the default is not zero.)
module trimSides(size=HUGE, offset=5) {
  trimLeft(size, offset)
    trimRight(size, offset)
      children();
}

module trimBack(size=HUGE, offset=0) {
  difference() {
    union() {
      children();
    }
    moveBack(size/2 + offset)
      cube([size, size, size], center=true);
  }
}

module trimFront(size=HUGE, offset=0) {
  difference() {
    union() {
      children();
    }
    moveForward(size/2 + offset)
      cube([size, size, size], center=true);
  }
}

// Includes only the parts of the children that fit in the selected quadrant.
// q is a vector of sizes.
module includeQuadrant(q=[HUGE, HUGE, HUGE]) {
  intersection() {
    union() {
      children();
    }
    scale(q) {
      cube([1, 1, 1]);
    }
  }
}