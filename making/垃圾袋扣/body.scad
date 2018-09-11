include <../../lib/relativity.scad> // https://github.com/davidson16807/relativity.scad

module body() {
  width=30;
  height=7.8;
  differed("hole", "body,guard")
    box([20, width, height])
    align(bottom+x) {
      box([1, $parent_size.y+30, $parent_size.z+2], anchor=bottom, $class="guard")
      align(bottom+x)
      hulled(class="guard")
      box([0.1, $parent_size.y, $parent_size.z], anchor=bottom, $class="guard")
      align(bottom)
      box([10, width, $parent_size.z], anchor=bottom-x)
      align(bottom+x)
      box([73, width, $parent_size.z], anchor=bottom-x, $class="body")
      ;
      translated(y*7.5, [-1,1])
      translated(x*10, [1:8])
      colored("red")
      box([6, 5, height+10], anchor=bottom+x, $class="hole")
      ;
    }

}

intersected("cut", "not(cut)") {
  box([65, 100, 50], $class="cut");
  body();
}
