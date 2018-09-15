/* Quick ways to arrange a bunch of child objects in space.*/

// Arrange children in a line, in steps of 'diameter' in X.
module arrangeLine(diameter)
{
  translate([($children - 1) * -diameter / 2, 0])
  for (i = [0 : $children-1]) {
    translate([diameter * i, 0])
      children(i);
  }
}

// Arranges all children in a 2-D grid in X-Y, at their current Z coordinates.
// Specify the maximum dimension of any child in X or Y.
module arrange(diameter)
{
  root = ceil(sqrt($children-1));
  for (i = [0 : $children-1]) {
    translate([diameter * floor(i / root), diameter * (i % root)])
      children(i);
  }
}

// Arranges all children in a grid, distributed in X, Y, and Z.
// Just specify the outside dimension of any child.
module arrangeSpread(diameter)
{
  root = ceil(sqrt($children));
  translate([
    -diameter * (root - 1) / 2,
    -diameter * (root - 1) / 2,
    -diameter * (ceil($children / root) - 1) / 2.0
  ])
    for (i = [0 : $children-1]) 
    {
      translate([
        diameter * floor(i % root),
        diameter * floor((i + i / root) % root),
        diameter * floor(i / root)
      ])
        children(i);
    }
}

// Duplicate all children n times.
// Adaptively arranges them in a grid, in steps of 'diameter' in X and Y.
module duplicate(n, diameter)
{
  root = ceil(sqrt(n));
  for (j = [0 : $children-1]) {
    for (i = [0: n - 1]) {
      translate([diameter * floor(i / root), diameter * (i % root)])
        children(j);
    }
  }
}

// Same, but just in a line in X.
module duplicateLine(n, diameter)
{
  translate([(n - 1) * -diameter / 2, 0])
    for (i = [0 : n-1]) {
      translate([diameter * i, 0])
        for (j = [0 : $children-1])
          children(j);
    }
}

// Duplicate its children, mirrored in X.
// Uses the +X copy as is, and mirrors it for the -X copy.
// Pass mirror=false to turn off the duplicate.
module twin_x(mirror=true) {
  if (mirror)
    mirror([1, 0, 0])
      children();
  children();
}

// Duplicate its children, mirrored in +Y and -Y with the given offset.
module twin_y(mirror=true) {
  if (mirror)
    mirror([0, 1, 0])
      children();
  children();
}

// Duplicate its children similarly, in both x and y.
module twin_xy(mirrorX=true, mirrorY=true) {
  twin_x(mirrorX)
    twin_y(mirrorY)
      children();
}

// Generate four of its children (usually just one child),
// centered in X-Y with the given distance between them (an array in X and Y).
// If tx and ty are specified, translate all children by that much.
// If either component of d is zero, only generate two duplicates.
// If both components are zero, just generate one child, centered.
module corners(d, t=[0, 0]) {
  translate(t)
    if (d[0] != 0 && d[1] != 0) {
      twin_xy()
        translate(d / 2)
          children();
    } else if (d[0] != 0) {
      twin_x()
        translate(d / 2)
          children();
    } else if (d[1] != 0) {
      twin_y()
        translate(d / 2)
          children();
    }
}
