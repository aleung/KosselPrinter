include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

d_out = 54;
d_in = 24;
sleeve_thickness = 1.5;
sleeve_length = 5;
thickness = 2;
d_mortise = 8.2;
d_tenon = 8;

$fn=60;

differed("cut", "not(cut)") {
  rod(d=d_out, h=thickness)
    align(top)
      rod(d=d_in+sleeve_thickness*2, h=sleeve_length, anchor=bottom);
  rod(d=d_in, h=sleeve_thickness*10, $class="cut");
    box([d_out, d_out, sleeve_thickness*10], anchor=y, $class="cut");
  translated(-(d_out+d_in)/4*x+(d_tenon/3)*y) rod(d=d_mortise, h=thickness+1, $class="cut");
}
translated((d_out+d_in)/4*x-(d_tenon/3)*y) rod(d=d_tenon, h=thickness);
