include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

toothpaste_width = 20;
bar_diameter = 10;
bar_length = 40;
height = 15;
thickness = 5;
to_wall_distance = 12;
$fn=30;

width = toothpaste_width * 2 + bar_diameter * 4;

differed("hole","not(hole)") {
  box([width, thickness, height], anchor=y-z) {
    mirrored(x) {
      // side bar
      hulled() {
        align(x-y+z) rod(d=bar_diameter, h=bar_length-bar_diameter, orientation=y, anchor=x+y+z)
          align(-y) ball(d=bar_diameter);
        align(x-y-z) box([bar_diameter, bar_length-bar_diameter, height-bar_diameter], anchor=x+y-z)
          align(-y) rod(d=bar_diameter, h=height-bar_diameter);
      };
      // connecter
      align(x+y) box([10, to_wall_distance, $parent_size.z], anchor=x-y);
      align(x+y) box([10.1, 7, $parent_size.z-6], anchor=x-y, $class="hole");
    }
    // middle bar
    hulled() mirrored(x) {
      align(-y+z) rod(d=bar_diameter, h=bar_length-bar_diameter, orientation=y, anchor=x+y+z)
        align(x-y) ball(d=bar_diameter);
      align(-y-z) box([bar_diameter*2, bar_length-bar_diameter, height-bar_diameter], anchor=y-z)
        align(x-y) rod(d=bar_diameter, h=height-bar_diameter, anchor=x+y);
    }
    // hook
    align(z) box([15, thickness, 10], anchor=-z)
      rod(d=5, h=thickness+1, orientation=y, $class="hole");
    align(-y-z) box([4, 20.3, height-5], anchor=y-z, $class="hole");
  }
}

translated(30*y) 
box([70, 20, 3.5], anchor=-z)
align(y-x) box([10, thickness+to_wall_distance, 3.5], anchor=-x-y);