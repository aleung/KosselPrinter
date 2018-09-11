include <../../lib/relativity.scad> // https://github.com/davidson16807/relativity.scad
include <configure.scad>

$fn=16;

module rotor() {
  hole_offset = 11;

  differed("hole", "not(hole)") {
    rod(d=rotor_d, h=rotor_thickness, anchor=bottom, $fn=total_numbers) {
      align(bottom) {
        rod(d=spindle_d+2, h=rotor_distance+rotor_thickness+1, anchor=bottom, $class="hole", $fn=60);
        rotated(z*360/total_numbers, n=[1:total_numbers])
          translated(x*hole_offset)
            rod(d=3.3, h=rotor_thickness+1, anchor=bottom, $class="hole");
      }
      align(top)
        rod(d=sleeve_d, h=rotor_distance, anchor=bottom);
      // notch
      align(bottom) translated(x*hole_offset)
        rod(d=5, h=rotor_thickness+1, anchor=-z, $class="hole")
          box([10,5,rotor_thickness+1], anchor=-x, $class="hole");
    }
    // notch
    translated(x*(rotor_d/2+3)) 
      orient(x+y)
        box([10,10,10], $class="hole");
  }
}

module dial() {
  differed("hole", "not(hole)") {
    rod(d=rotor_d, h=4, anchor=bottom, $fn=total_numbers) {
      align(top)
        rod(d=sleeve_d+4, h=4, anchor=bottom)
          align(top)
            rod(d=sleeve_d+0.5, h=6, anchor=top, $class="hole", $fn=60);
    }
  }
}

// rotor();

// translated(z*20)
// orient(-z)
// dial();

