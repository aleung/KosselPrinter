include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

toothpaste_width = 20;
bar_diameter = 10;
bar_length = 40;
height = 15;
thickness = 5;
to_wall_distance = 12;
$fn=30;

width = (toothpaste_width + bar_diameter * 2) * 3;

module middle_bar() {
  hulled() mirrored(x) {
    align(-y+z) rod(d=bar_diameter, h=bar_length-bar_diameter, orientation=y, anchor=x+y+z)
      align(x-y) ball(d=bar_diameter);
    align(-y-z) box([bar_diameter*2, bar_length-bar_diameter, height-bar_diameter], anchor=y-z)
      align(x-y) rod(d=bar_diameter, h=height-bar_diameter, anchor=x+y);
  }
  align(-y-z) box([4, 20.3, height-5], anchor=y-z, $class="hole");
}

module side_bar() {
  hulled() {
    align(x-y+z) rod(d=bar_diameter, h=bar_length-bar_diameter, orientation=y, anchor=x+y+z)
      align(-y) ball(d=bar_diameter);
    align(x-y-z) box([bar_diameter, bar_length-bar_diameter, height-bar_diameter], anchor=x+y-z)
      align(-y) rod(d=bar_diameter, h=height-bar_diameter);
  };  
}

module connector() {
  box([10, to_wall_distance, $parent_size.z], anchor=x-y);
  box([10.1, 7, $parent_size.z-6], anchor=x-y, $class="hole");
}

module hook() {
  align(z) box([15, thickness, 10], anchor=-z)
    rod(d=5, h=thickness+1, orientation=y, $class="hole");
}

differed("hole","not(hole)") {
  box([width, thickness, height], anchor=y-z) 
  mirrored(x) 
  {
    side_bar();
    align(x+y) connector();
    translated(toothpaste_width*x) middle_bar();
    align(x) translated(-7.5*x) hook();
  }
}

/*
translated(30*y) 
box([70, 20, 3.5], anchor=-z)
align(y-x) box([10, thickness+to_wall_distance, 3.5], anchor=-x-y);
*/