include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

// print settings:
// infill 15%
// layer height: 0.3mm
// perimeters: 3
// bottom solid layers: 3

height = 25;
d_inner = 120;
edges = 12;
d_outer = d_inner + 10;

differed("cut", "not(cut)")
  hulled("hullSide")
        rod(d=d_outer, h=0.01, anchor=bottom, $class="hullSide", $fn=edges)
          translated(height*z) rotated(360/edges/2*z) rod(d=d_outer, h=0.01, anchor=bottom)
            align(top) rod(d=d_inner, h=6, anchor=top, $class="cut", $fn=60)
              align(bottom) {
                rod(d=d_inner-15, h=height-6-1.2, anchor=top);
              } 
rotated(60*z, n=[1:3]) box([d_inner, 1.5, height-6], anchor=bottom);
