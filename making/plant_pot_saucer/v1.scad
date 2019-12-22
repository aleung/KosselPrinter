include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

// print settings:
// infill 15%
// layer height: 0.3mm
// perimeters: 3
// bottom solid layers: 3

height = 20;
d_inner = 120;
edges = 12;
d_outer = d_inner + 10;
d_bottom = d_outer - 30;

differed("cut", "not(cut)", "rib")
   hulled("bottom1") 
   hulled("bottom2") 
   hulled("side")
    rod(d=d_bottom, h=4, anchor=bottom, $class="bottom1", $fn=120)
      align(top) rod(d=d_bottom+7, h=0.01, anchor=bottom)
      align(bottom) rod(d=d_bottom+7, h=2, anchor=bottom, $class="bottom2")
        align(top) rod(d=d_outer, h=0.01, anchor=bottom, $fn=edges)
        align(bottom) rod(d=d_outer, h=0.01, anchor=bottom, $class="side")
          translated(height*z) align(bottom) rotated(360/edges/3*z) rod(d=d_outer, h=0.01, anchor=bottom)
            align(top) rod(d=d_inner, h=6, anchor=top, $class="cut", $fn=30)
              align(bottom) {
                rod(d=d_bottom-2, h=height-1.2, anchor=top);
                rotated(60*z, n=[1:3]) box([d_bottom, 1.2, height], anchor=top, $class="rib");
              } 
