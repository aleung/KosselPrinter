include <../../lib/relativity.scad> // https://github.com/davidson16807/relativity.scad
include <configure.scad>

$fn=36;

rod(d=5, h=rotor_distance-1)
rod(d=3, h=rotor_thickness, anchor=bottom);
