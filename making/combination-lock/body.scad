include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad
include <configure.scad>

$fn=16;

module bottom_case() {
  box([50,50,2], anchor=top)
    align(top) {
      rod(d=spindle_d, h=(rotor_distance+rotor_thickness)*2, anchor=bottom, $fn=60);
      children();
    }
}

module top_case() {
  differed("hole", "not(hole)")
    box([50,50,2], anchor=bottom)
      align(bottom) 
        rod(d=sleeve_d+6, h=3, anchor=bottom, $class="hole");
}

module case() {
  colored("lightblue") {
    bottom_case()
    translated(z*(rotor_thickness*2+rotor_distance+1))
    top_case();
  }
}

// case();