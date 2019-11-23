include <../../lib/relativity.scad/relativity.scad>

differed("hole")
box([100, 9, 5]) {
  translated(5*x) translated(25*x, n=[-1:1]) box([22, 4, 6], $class="hole");
  align(-x-y) box([16, 10, $parent_size.z], anchor=-x-y)
    align(-x+y) box([1.5, 7.9, $parent_size.z], anchor=-x-y);
  align(-x-y) translated(5*x) mirrored(x) translated(2.5*x) box([3, 6.3, 6], anchor=-x-y, $class="hole");
  hulled("hull") {
    align(x+y) box([3, 3, $parent_size.z], anchor=-x-y, $class="hull")
      align(y) box([3, 3, $parent_size.z], anchor=-y, $class="normal");
    align(x+y) box([5, $parent_size.y, $parent_size.z], anchor=x+y, $class="hull");
  }
  align(x-y) color("red") box([5, 2.5, 5], anchor=x+y);
}
