include <body.scad>
include <rotor.scad>

module layer(n) {
  translate(z*(rotor_distance+rotor_thickness+0.1)*n)
  children();
}

intersected("cut", "not(cut)") {
  box([100, 100, 100], anchor=y, $class="cut");
  case();
  layer(0) rotor();
  layer(1) rotor();
  layer(2) translated(z*3) orient(-z) dial();
}
