// bridge spans, lenght unit in 10mm. [start:step:end]
spans = [3:2:15]; 
thickness = 1.2;
h_base = 1.5;
z_delta = thickness / 2;

module bridge(i, i0, step) {
  z = z_delta*(i-i0)+h_base;
  // bridge
  translate([0, 7*i/step, z]) cube([5*i+4, 4, thickness]);
  // pillar
  at(i, step) cube([4, 4, z]);
}

module at(i, step) {
  translate([5*i, 7*i/step, 0]) children();
}

module x_mirror() {
  children();
  mirror([1,0,0]) children();
}

module raft() {
  translate([4,2,0]) cylinder(d=10, h=1);
}

x_mirror() {
  for(i=spans)
    bridge(i, spans[0], spans[1]);
  hull()
    for(i=spans) 
      at(i, spans[1]) raft();
}
