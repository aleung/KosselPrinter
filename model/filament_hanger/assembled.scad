use <parts.scad>

color("green")
bar_bearing();

color("orange") bracket();

color("blue")
translate([0,0,25])
uphold();

// translate([-13,0,40])
// topfix();

translate([0,0,60])
topfix2();

translate([0,0,-30])
baffle();