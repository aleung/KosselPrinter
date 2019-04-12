use <parts.scad>

color("green")
bar_bearing();

bracket();

color("blue")
translate([0,0,30])
uphold();

translate([-13,0,40])
topfix();

translate([0,0,-30])
baffle();