W1 = 5;
W2 = 1.5;
W3 = 4;
H = 6;
L = 13;
thick = 1.5;
flang = 1;

stand = 5;

cube([L + thick, thick, W1 + W2]);
color("green") translate([0, -flang, 0]) cube([L + thick, flang, W2]);

color("red") cube([thick, H + thick, W1 + W2]);

color("blue") translate([L + thick, -flang * 2, 0]) cube([thick, thick + flang * 2, W3]);

translate([0, 0, -stand]) cube([0.5, 0.5, stand]);
