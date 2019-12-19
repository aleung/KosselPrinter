include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

d_nail_hole = 2.4;
d_nut = 17;

d_plumb = d_nut + 4;
fn = 36;
$fn = fn;

module upper() {
  differed("cut") {
    hulled("hull")
      rod(d=d_nut-0.4, h=8, anchor=bottom, $class="hull")
        align(top)
          rod(d=3, h=8, anchor=bottom);
    
    class("cut") hulled("hull")
      rod(d=d_nut-3, h=7, anchor=bottom, $class="hull")
        align(top) rod(d=1, h=8, anchor=bottom, $class="hull")
          align(top) rod(d=1, h=8, anchor=bottom, $class="cut");
  }
}

module plumbbob() {
  differed("cut") {
    hulled("hull")
      rod(d=d_nail_hole*2, h=0.01, anchor=bottom, $class="hull")
        align(bottom) translated(15*z)
          rod(d=d_plumb, h=15, anchor=bottom);
    
    class("cut") hulled("hull")
      rod(d=d_nail_hole, h=10, anchor=bottom)
        align(top) rod(d=d_nail_hole, h=5, anchor=bottom, $class="hull")
          align(top) rod(d=d_nut, h=5, anchor=bottom, $fn=6)
            align(top) rod(d=d_nut, h=15, anchor=bottom, $fn=fn, $class="cut");
  }
}

module mandril() {
  rod(d=d_nut/3, h=5, anchor=bottom)
    align(top)
      rod(d=d_nut-1, h=2, anchor=bottom);
}

module ring() {
  rotate_extrude()
    translate([4,0,0]) circle(d=3);
}

module winder_cross_section() {
    translate([d_plumb/2, 0, 0]) {
      difference() {
        translate([3,0,0]) square([6, 10], center=true);
        hull() {
          translate([4,0,0]) square([4, 2], center=true);
          translate([6,0,0]) square([0.01, 8], center=true);
        }
      }
    }

}

module winder() {
  inside_height = 60 - d_plumb;
  difference() {
    union() {
      rotate([-90,0,0]) mirrored(y) translate([0,inside_height/2,0])
        rotate_extrude(angle=180)
          children();
      mirrored(x)
        linear_extrude(height=inside_height, center=true)
          children();
      delta_y = sqrt(pow(d_plumb/2, 2) - pow(d_plumb/2-1, 2));
      mirrored(x) mirrored(y)
        translated(d_plumb/2*x + delta_y*y) 
          rotated(45*z) box([1,1,inside_height]);
    }
    mirrored(x) translated((d_plumb/2+6)*x) rotated(45*y) box([2,11,2]);
    mirrored(z) translated((d_plumb+inside_height+12)/2*z) box([1,11,6]);
    translated(2*x, n=[-1,1]) rod(d=2, h=inside_height, anchor=bottom);
    mirrored(y) translated(-5*y) box([d_plumb*2, 10, inside_height], anchor=y);
  }
}


if ($preview) {
  difference() {
    plumbbob();
    box([100, 100, 100], anchor=x+y-z);
  }

  translated(16*z) %mandril();

  translate([0,0,31]) rotate([90,0,0])
    color("red") ring();

  color("orange")
  translated(25*z)
  difference() {
    upper();
    box([100, 100, 100], anchor=x+y-z);
  }

  translate([0,0,20]) 
    winder() winder_cross_section();

} else {
  translated(20*x+30*z) mirror([0,0,1]) plumbbob();
  translated(20*y+7*z) mirror([0,0,1]) mandril();
  translated(-20*y) upper();
  ring();
  translate([-30,0,0]) rotate([90,0,0]) winder() winder_cross_section();
}
