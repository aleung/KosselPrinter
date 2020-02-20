d=6;
h=20;
hole_height=3;

$fn=60;

hole_count = round(h/(hole_height+1));

module x_mirror() {
  children();
  mirror([1,0,0]) children();
}

x_mirror() {
intersection() {
  translate([0,0,-h/2]) cube([d+8, d+2, h]);

  difference() {
    union() {
      cylinder(d=d+4, h=h, center=true);
      cube([d+9, 4, h], center=true);
    }
    union() {
      cylinder(d=d-0.6, h=h+0.01, center=true);
      for (i=[-hole_count:hole_count]) {
        translate([d/2+2.5, 0, (hole_height+1)*i]) cube([1.5,5,hole_height], center=true);
        translate([0,0,i*hole_height]) cylinder(d=d, h=hole_height-0.6, center=true);
      }
    }
  }
}
}