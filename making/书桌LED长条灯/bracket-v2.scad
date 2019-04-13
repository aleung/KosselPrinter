include <../../lib/relativity.scad/relativity.scad>
include <../../lib/polyScrewThread_r1.scad>

length = 55;
width = 20;
height = 10;
slot_length = 25;
slot_width = 16;
slot_depth = 8;

module main() {
  box([length-slot_length, width, 5], anchor=-x-z)
  align(x+z)
  differed("slot")
  box([slot_length, width, height], anchor=-x+z)
  align(x+z) 
  box([$parent_size.x, slot_width, slot_depth], anchor=x+z, $class="slot");
}


main();
translate(10*x) rotate([180,0,0]) screw_thread(14, 3, 55, 12, PI/2, 2);

translate(-20*x) hex_nut(16, 12, 3, 55, 14.5, 0.5);    
