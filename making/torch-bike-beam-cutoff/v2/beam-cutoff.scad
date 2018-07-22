// torch diameter
torch_diameter = 45.3;

thickness = 2;

beam_diameter = 22;
screen_overhang = 45;

// height of ring
ring_height = 15;

// preview = true;

$fn=100;

module beam(angle,length=100) {
  translate([0,0,-25]) cylinder(r1 = 0, r2 = tan(angle)*length, h=length);
}

module ring(height) {
	union() {
		difference() {
			cylinder(height, d = torch_diameter + thickness*2);
			translate([0,0,-1]) cylinder(height+2, d = torch_diameter);
		}	
	}
}

module beam_cutter() {
	module screen(y_size=thickness) {
		height = sqrt(pow(screen_overhang-thickness*2, 2) + pow(beam_diameter/2, 2));
		width = sqrt(pow(torch_diameter, 2) - pow(beam_diameter/2, 2));
		multmatrix(m=[[1, 0, 0, -width/2],
		              [0, 1, (beam_diameter-torch_diameter)/2/screen_overhang, torch_diameter/2],
		              [0, 0, 1, 0],
		              [0, 0, 0, 1]])
		  cube([width, y_size, screen_overhang]);
	}
	difference() {
		union() {
			intersection() {
  			screen();
        cylinder(d = torch_diameter+thickness*2, h=100);
			}
		  ring(screen_overhang);
		}
		translate([0, thickness, -0.01]) scale([1.01, 0.99, 1.01]) screen(100);
		translate([-50, -100+beam_diameter/2, 0]) cube([100, 100, 100]);
		translate([0, 0, screen_overhang - 5]) difference() {
			cylinder(d = torch_diameter + thickness*3, h = 6);
			cylinder(d1 = torch_diameter + thickness*2, d2 = torch_diameter - 6, h=6);
		}
	}
}

module whole() {
	ring(ring_height);
	for(n=[1:6]) {
		rotate([0,0,n*60]) {
			translate([torch_diameter/2, 0, ring_height-3]) rotate([0, -45, 0]) cube([2,2,2]);
		}
	};
	translate([0, 0, ring_height]) beam_cutter();
}

if (preview) {
	beam_length = 70;  // change it to see beam cutting
	union() {
		whole();
		color("Red", 0.7) beam(7, beam_length);
		color("OrangeRed", 0.3) beam(30, beam_length);
	}
} else {
	whole();
}