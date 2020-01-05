// Relativity SCAD library
// https://raw.githubusercontent.com/aleung/relativity.scad/master/relativity.scad
include <../../lib/relativity.scad/relativity.scad>

differed("cut", "not(cut)", "normal")
box([80, 4, 17])
  align(z) box([76, 1, 15], anchor=z, $class="cut") {
    mirrored(x) align(x) box([5, 1.5, 15], anchor=x);
    // align(y-z) box([66, 0.3, 2], anchor=y-z, $class="normal");
  }
