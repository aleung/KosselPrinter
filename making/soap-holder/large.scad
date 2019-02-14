include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad
use <../../lib/BezierScad.scad>  // http://www.thingiverse.com/thing:8443

// size: 147*100*20

height = 20;
depth = 100;
wall_thickness = 3;
wall_distance = 5;
max_sinkage = 8;
num_walls = 19;  // must be odd number

debug = true;

width = wall_thickness * num_walls + wall_distance * (num_walls-1);
echo (width=width);

module valley() {
  control_points=[
    [5, 0],
    [3, 0],
    [3, -1],
    [0, -1]
  ];

  translated(-z*wall_thickness)
  mirrored(x)
  BezArc(control_points, height=wall_thickness*2);
}


module wall(sinkage) {
  round_r = 6;
  differed("cut", "not(cut)")
  hulled("not(cut)")
  box([wall_thickness, depth, height-round_r], anchor=bottom-y) {
    align(top) {
      align(y)
        box([wall_thickness, round_r, round_r], anchor=y-z);
      align(-y)
        rod(r=round_r, h=wall_thickness, orientation=x, anchor=-y);
    }
    if (!debug) {
      align(bottom-x) {
        translated(z*height)
        scaled([1, (depth-round_r*2)/10, sinkage])
        rotated(y*90)
        rotated(z*90)
        colored("red", "*")
        class("cut")
        valley();
      }
    }
  }
}

module baseplate() {
  control_points=[
    [height*2/3, depth],
    [2, -2],
    [2, -2],
    [1, -2],
    [0, -4],
    [-5, -5]
  ];
  translated(x*width/2)
  rotated(-y*90)
  class("base")
  BezWall(control_points, height=width);
}

module support() {
  translated(x*30, n=[-2:2])
  hulled() {
    translated(y*depth+z*height*2/3) box([0.2, 0.1, height], anchor=z);
    box([0.2, 0.01, 1], anchor=-z);
    translated(-y*4-z*4) box([0.2, 0.1, 3]);
  }
}

function sinkage(x) = debug ? 0 : sqrt(pow(max_sinkage,2) - pow(x*max_sinkage*2/width,2));

rotated(-x*90) {

  color("blue") baseplate();

  differed("cut", "not(cut)") {
    translated(y*depth) box([width, wall_thickness, height*2/3-1], anchor=y-z);

    mirrored(x)
    for (offset = [0 : wall_thickness+wall_distance : width/2] ) {
      echo(offset=offset);
      echo(s=sinkage(offset));
      translated(x*offset)
      wall(sinkage(offset));
    }

    class("cut")
    hulled() {
      box([width-wall_thickness*2, 0.1, 1], anchor=bottom);
      translated(y*(depth-wall_thickness))
      box([width-wall_thickness*2, 0.1, height*2/3-1], anchor=bottom-y);
    }

    class("cut")
    translated(y*90) rotated(x*35)
      box([width, depth, height], anchor=z-y);
  }

  color("orange") support();

}
