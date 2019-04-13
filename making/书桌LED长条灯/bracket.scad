include <../../lib/relativity.scad/relativity.scad>
include <../../lib/polyScrewThread_r1.scad>

length = 55;
width = 20;
height = 10;
slot_width = 16;
slot_depth = 7;

module main() {
  differed("slot")
  box([length, width, height], anchor=-x-z) {
    align(x+z) box([$parent_size.x-1.5, slot_width, slot_depth], anchor=x+z, $class="slot");
    align(-x+z) translated(5*x) box([5, width+1, 5], anchor=-x+z, $class="slot"); // 出线槽
  }
}

main();
translate(10*x) rotate([180,0,0]) screw_thread(15, 3, 55, 7, PI/2, 2);

translate(-30*x) hex_nut(17, 7, 3, 55, 15, 0.5);    
