include <../../lib/relativity.scad/relativity.scad>

d1 = 25;
d2 = 30;
dd = 4;
h1 = 3;
h2 = 3;
hm = 1;

$fn = 30;

differed("hole")
hulled("hull")
rod(d=d1+dd, h=h1, $class="hull") {
  rod(d=d1, h=h1, $class="hole");
  align(z)
    rod(d=d2+dd, h=hm+h2, anchor=-z, $class="hull")
      align(z)
        rod(d=d2, h=h2, anchor=z, $class="hole");
}
