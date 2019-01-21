include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

d = 12.5;
d_inner = 9.5;
height = 10;

distance = 1.5;
thickness = 0.8; // 0.68;
n = 2;

// ----------------

echo( pow(distance - thickness, 2) / pow(distance, 2) * 100, "%" );

$fn=30;

differed("hole", "not(hole)") {
  rod(d=d, h=height);
  rod(d=d_inner, h=height+1, $class="hole");
}

rotated(z*90, n=[0,1])
translated(x*distance, n=[-n:n])
  box([thickness, d_inner, height]);
