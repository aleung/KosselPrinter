include <../../../lib/ISOThread.scad>

// torch diameter
torch_diameter = 45.3;

hood_thickness = 4;

beam_diameter = 10;
beam_cutter_overhang = 45;

// height of ring
ring_height = 15;
adjust_range = 15;

// preview = true;

module ring(length) {
	union() {
		difference() {
			iso_thread(m = torch_diameter + 4, l = length, p=2);
			translate([0,0,-1]) cylinder(length+2, d = torch_diameter);
		}	
		for(n=[1:6]) {
			rotate([0,0,n*60]) {
				translate([torch_diameter/2-2, 0, 0]) cube([2,2,2]);
			}
		};
	}
}

module beam_cutter() {
	module x(inner=false) {
		t = 4;
		hull() {
			cylinder(d = torch_diameter + hood_thickness*2 + (inner?-3:0), h = 0.1);
			translate([0, 0, beam_cutter_overhang-3]) 
			  resize([beam_diameter + t*2 + (inner?-t:0), torch_diameter + 15 + (inner?0:t), 5 + (inner?0:t*2)]) sphere(d=1);
		}
	}
	difference() {
		x();
		translate([0,0,-0.1]) x(true);
		translate([-beam_diameter/2, -50, 0]) cube([100, 100, 100]);
	}
}

module hood() {
	height = ring_height + adjust_range;
	union() {
		intersection() {
			cylinder(height, d = torch_diameter + hood_thickness*2);
			iso_nut(m = torch_diameter + 4, w=height, p=2, t=0.3);
		}
		translate([0, 0, height]) beam_cutter();
	}
}

if (preview) {
	difference() {
		union() {
			color("SteelBlue") ring(ring_height);
			translate([0, 0, -3]) hood();
		}
		translate([-50, 0, -20]) cube([50, 50, 200]);
	}
} else {
	union() {
		ring(ring_height);
		translate([0, torch_diameter + 20, 0]) hood();
	}
}