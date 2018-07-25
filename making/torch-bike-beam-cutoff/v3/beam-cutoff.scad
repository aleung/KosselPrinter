// ---- parameters ----

torch_diameter = 45.3;
cutted_beam_min_radius = 10;

thickness = 2;

reflector_overhang = 55;
ring_height = 15;

preview = true;    // remark it for STL output
beam_length = 95;  // change it to see how beam is cutted

// --------------------

$fn=100;

module beam(angle,length=100) {
  translate([0,0,-25]) cylinder(r1 = 0, r2 = tan(angle)*length, h=length);
}

module ring(height, d1=torch_diameter, d2=torch_diameter) {
	difference() {
		cylinder(height, d1 = d1 + thickness*2, d2 = d2 + thickness*2);
		translate([0,0,-1]) cylinder(height+2, d1 = d1, d2 = d2);
	}	
}

module triPrism(theta, t, h, seq) {
	a = t/tan(theta);
	b = t*tan(2*theta);
	translate([(a+b)*seq, 0, 0])
	  linear_extrude(height=h)
	    polygon([[-b, 0], [a, 0], [0, -t]]);
}

module reflector(y_size=thickness, flat=false) {
	module x() {
		translate([-0.1, 0, 0]) cube([width, y_size, reflector_overhang]);
		if (!flat) {
			for(seq=[0:1])
				triPrism(12, 2, reflector_overhang, seq);
		}
	}
 	height = sqrt(pow(reflector_overhang-thickness*2, 2) + pow(cutted_beam_min_radius, 2));
	width = 100;
	multmatrix(m=[[1, 0, 0, 0],
								[0, 1, (cutted_beam_min_radius*2-torch_diameter)/2/reflector_overhang, torch_diameter/2],
								[0, 0, 1, 0],
								[0, 0, 0, 1]])
	  union() {
			x();
			mirror([1,0,0]) x();
		}
}

module beam_cutter() {
	d2 = torch_diameter+reflector_overhang/2;

	intersection() {
		reflector();
		cylinder(d1 = torch_diameter+thickness*2, d2=d2, h=reflector_overhang);
	}

	difference() {
		ring(reflector_overhang, d1=torch_diameter, d2=d2);
		translate([0, thickness, -0.01]) scale([1.01, 0.99, 1.01]) reflector(100, true);
		multmatrix(m=[[1, 0, 0, -100],
		              [0, 1, cutted_beam_min_radius/reflector_overhang, -100],
		              [0, 0, 1, 0],
		              [0, 0, 0, 1]])
		  cube([200, 100, 100]);
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
	whole();
	color("Red", 0.5) beam(7, beam_length);
	color("OrangeRed", 0.3) beam(30, beam_length);
} else {
	whole();
}