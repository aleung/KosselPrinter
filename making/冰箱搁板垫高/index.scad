include <../../lib/relativity.scad/relativity.scad> // https://github.com/davidson16807/relativity.scad

width=15;
height=18;

module A() {
differed("cut", "not(cut)")
  box([60, width, height], anchor=bottom) {
    align(bottom) box([30, width+1, 12], anchor=bottom, $class="cut");
    mirrored(x) align([1,-1,1]) translated(4*y) box([5,4,5], anchor=[1,-1,-1]);
  }
}

module B() {
differed("cut", "not(cut)")
  box([40, width, height], anchor=bottom) {
    align([0,1,-1]) box([16,8,5], anchor=[0,1,1]);
    align(top) box([20, width+1, 6], anchor=top, $class="cut");
    mirrored(x) align([1,-1,1]) translated(4*y) box([5,4,5], anchor=[1,-1,-1]);
  }
}

// translated(-40*x) A();
translated(20*x) B();