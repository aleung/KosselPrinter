// $Header$

// cap/mount for PET bottle, usually 16oz, 20oz, 1l, 2l
// https://www.thingiverse.com/thing:897760

// Cola bottle (PCO 1881)
threadOD = 27.4;
threadID = 24.7;
threadPitch = 2.9;//3.2;
nTurns = 2.3;
toLip = 11;
neckD = 21.4;


threadDepth = (threadOD-threadID)/2;

//PETbottleHolder();
//rotate([180,0,0]) PETnozzleFins();

//%translate([0,-100,0]) difference() {
//  scale([0.98,0.98,1]) PETtop();
//  translate([0,0,-4]) cylinder(r1=neckD/2-1,r2=neckD/2,h=16);
//}

//%translate([100,100,0])
//  PETtap();

//%translate ([100,0,0])
  PETcoupler();

//%translate ([0,100,0])   //PETnozzle1();
//  PETnozzle();

//translate([-50,0,0]) //difference() {
  //torous();
  //%ventouri();
  //translate([-10,-10,0]) cube([20,20,40],center=true); }

//------------------------------------------------------------

module PETnozzleFins() {
  difference() {
    union() {
      hull() {
        cylinder(r=threadOD/2+3,h=1,$fn=60);
        translate([0,0,9]) cylinder(r1=threadOD/2+3,r2=threadOD/2,h=3.5,$fn=60);
      }
      translate([0,0,13]) PETnozzle();

      for (a=[0,120,240]) rotate([0,0,a])
        translate([20,0,-6]) rotate([-3,0,0]) rocketFin1();
        //translate([10,0,-4]) rotate([-5,0,0]) rocketFin();

      // drawn support
      color("Cyan") difference() {
        translate([0,0,39]) cylinder(r=8 ,h=16,$fn=24);
        translate([0,0,38]) cylinder(r=7.5,h=22,$fn=24);
      }
    }

    translate([0,0,-.1]) cylinder(r1=threadOD/2+.3,r2=threadOD/2-.2,h=1.5,$fn=80);
    translate([0,0,10]) cylinder(r1=8,r2=7,h=3,$fn=60);
    translate([0,0,8.5]) rotate([180,0,0]) import("PETtap.stl"); // PETtap();

    // chop off for regular fins
    //translate([0,0,-10]) cube([100,100,20],center=true);

    // chop offs for flat bottom fins
    translate([0,0,64]) cube([200,200,20],center=true);

    //translate([0,0,-30]) cube([50,50,100]);
  }

}

module rocketFin() {
  hull() {
    translate([0,0,8]) scale([1,1,4]) sphere(r=3,$fn=16);
    translate([50,0,60]) scale([1,1,25]) sphere(r=1,$fn=16);
    translate([20,0,60]) scale([1,1,3]) sphere(1);
  }
}

module rocketFin1() {
rThin=0.6;
  union() {
    hull() {
      translate([40,0,-40]) scale([6,1,6]) sphere(r=rThin,$fn=16);
      //translate([5,0,55])   sphere(r=rThin,$fn=16);
      translate([-13,0,25])   sphere(r=rThin,$fn=16);
      translate([50,0,50]) scale([20,1,20]) sphere(r=rThin,$fn=36);
      translate([30,0,50]) scale([20,1,20]) sphere(r=rThin,$fn=36);
      translate([40,0,60]) scale([29,1, 3]) sphere(r=rThin,$fn=36);
    }
    hull() {
      translate([-11,0,21]) rotate([0,-40,0]) scale([1,1,3]) sphere(r=2,$fn=16);
      translate([-4,0,9]) sphere(r=2.2,$fn=16);


      translate([-3,0,30]) sphere(r=rThin,$fn=16);
      translate([ 8,0, 6]) sphere(r=1,$fn=16);
    }
  }
}


module PETbottleHolder1() {
fr=4;
tr=70-fr;
wd=30; // water depth is this, plus 3 since ring goes to -3
xOff=-15;  // offset from center for bottle
  intersection() {
    translate([-75,-75,-3]) cube([150,150,3+wd+10-.1]);

    difference() {
      union() {
        torous(tr,fr,4);

        for (a=[0:72:358]) {
          hull() {
            translate([tr*cos(a),tr*sin(a),0])
              scale([1,1,2]) sphere(r=2,$fn=16);
            translate([xOff+16*cos(a),16*sin(a),0]) {
              translate([0,0,wd+8])
                scale([1,1,3]) sphere(r=1.5,$fn=16);
              translate([0,0,-3]) sphere(r=.3);
            }

          }

          //hull() {
          //  translate([xOff+(threadOD+4)*cos(a)/2,(threadOD+4)*sin(a)/2,-3])
          //    cylinder(r1=.1,r2=1,h=wd+16,$fn=10);
          //  translate([tr*cos(a),tr*sin(a),-3]) sphere(r=.1,$fn=10);
          //}
        }

        // central main cylinder
        translate([xOff,0,0]) {
          translate([0,0,wd])
            cylinder(r1=threadOD/2+6,
                     r2=threadOD/2+4,h=10,$fn=60);
          difference() {
            translate([0,0,-3])
              cylinder(r1=threadOD/2+2.25,
                       r2=threadOD/2+5.8,h=wd+3.1,$fn=60);     
            translate([0,0,-4])
              cylinder(r1=threadOD/2+1.9,r2=threadOD/2+.2,h=wd+5,$fn=60);

            for(a=[31:72:355])
              translate([16*cos(a),16*sin(a),19])
                scale([1,1,3]) sphere(r=5,$fn=20);
          }
        }    
      }

      translate([xOff,0,wd-3]) {
        cylinder(r=threadOD/2+.3,h=3+2.5,$fn=60);
        translate([0,0,-20]) cylinder(r1=1,r2=threadOD/2-1,h=20.1);

        translate([0,0,3+12.5]) rotate([180,0,0])
          scale([1.02,1.02,1]) PETtop();
      }
    }
  }
}

module PETtop() union() {
  translate([0,0,-2.9]) cylinder(r=threadID/2+3,h=3,$fn=100);

  cylinder(r=threadID/2-.2,h=toLip,$fn=100);

  // can't really do a hull to make threads thicker, so
  // just repeat them.  Its not perfect, but you won't be able
  // to tell by the time it gets through the slicer
  for(offst=[.4,.7,1]) translate([0,0,3.25-offst])
    linear_extrude(height=nTurns*threadPitch,twist=-nTurns*360)
      translate([threadDepth,0,0]) circle(r=threadID/2 + threadDepth/2);
}

// for removing from a solid to make a place
// where a PET bottle can be screwed in
module PETtap(h=10) {
hh=h+0.5; // a little thread over the top
  union() {
    translate([0,0,-1]) cylinder(r=threadOD/2+.3,h=1  ,$fn=100);
    translate([0,0,-2]) cylinder(r=threadID/2+.3,h=h+2,$fn=100);

    // can't really do a hull to make threads thicker, so
    // just repeat them.  Its not perfect, but you won't be able
    // to tell by the time it gets through the slicer
    for(offst=[-.05,-.25,-.45,-.65]) translate([0,0,offst])
      linear_extrude(height=hh,twist=-(hh/threadPitch)*360,slices=80)
        translate([threadDepth,0,0])
          circle(r=threadID/2 + threadDepth/2,$fn=48);
  }
}

// like PET tap, but faster to render.  NOT for production use.
module PETtapProxy(h=10) {
hh=h+0.5; // a little thread over the top
  union() {
    translate([0,0,-1]) cylinder(r=threadOD/2+.3,h=1  ,$fn=100);
    translate([0,0,-2]) cylinder(r=threadID/2+.3,h=h+2,$fn=100);

    // can't really do a hull to make threads thicker, so
    // just repeat them.  Its not perfect, but you won't be able
    // to tell by the time it gets through the slicer
    //for(offst=[-.05,-.25,-.45,-.65]) translate([0,0,offst])
    //  linear_extrude(height=hh,twist=-(hh/threadPitch)*360,slices=80)
    //    translate([threadDepth,0,0])
    //      circle(r=threadID/2 + threadDepth/2,$fn=48);
  }
}

module PETcoupler() {
  difference () {
  cylinder(r=threadOD/2+3,h=18,center=true,$fn=60);

  translate([0,0, 1])                   import("PETtap.stl"); //PETtap();
  translate([0,0,-1]) rotate([180,0,0]) import("PETtap.stl"); //PETtap();

  translate([0,0, 7.1]) cylinder(r1=threadID/2,r2=threadOD/2+.3,h=2,$fn=80);
  translate([0,0,-9.1]) cylinder(r2=threadID/2,r1=threadOD/2+.3,h=2,$fn=80);
}
}

// cut a hole in standard cap, and push this through it
module PETnozzle() {
  difference() {
    union() {
      translate([0,0,-1.5]) cylinder(r1=threadID/2-0.3,r2=threadID/2-.7,h=2,$fn=80);
      cylinder(r1=9,r2=8,h=26);
    }
    translate([0,0,-8]) scale([1,1,2]) sphere(8,$fn=40);
    translate([0,0,11]) ventouri();
    translate([0,0,32]) scale([8,8,18]) sphere(1,$fn=80);

    translate([0,0,12]) torous(rc=12,r1=6,r2=10);
    //%translate([0,0,20]) torous(rc=20,r1=9,r2=14);
  }
}

// this one has small hole, and is complete with taps for bottle
module PETnozzle1() {
  difference() {
    cylinder(r=threadOD/2+2,h=40);

    translate([0,0,-3]) scale([1.01,1.01,1]) PETtop();
    //cylinder(r=neckD/2-.1,h=12,$fn=80);
    translate([0,0,7]) scale([neckD/2,neckD/2,0.8*neckD]) sphere(1,$fn=40);
    translate([0,0,26.2]) intersection() {
      scale([1,1,.5]) ventouri();
      cylinder(r=1.8,h=10,center=true,$fn=32);
    }
    translate([0,0,47.8]) scale([8,8,20]) sphere(1,$fn=80);

    translate([0,0,29]) torous(rc=14,r1=6,r2=14);
    translate([0,0,20]) torous(rc=20,r1=9,r2=14);
  }
}

module torous(rc=5,r1=4,r2=8) {
  rotate_extrude($fn=80) translate([rc,0,0]) scale([r1,r2]) circle(r=1);
}

module ventouri() difference() {
  cylinder(r=5,h=14,center=true,$fn=32);
  torous(7,4,8);
}

module PETbottleHolder() {
wd=30; // water depth is this, plus 3 since ring goes to -3
xOff=-15;  // offset from center for bottle
  intersection() {
    translate([-75,-75,-3]) cube([150,150,3+wd+10-.1]);

    difference() {
      bottleHolderShell(wd,xOff);

      translate([xOff,0,wd-3]) {
        translate([0,0,3]) PETtap();
        translate([0,0,11.5])
          cylinder(r1=threadID/2+.5,r2=threadOD/2+.3,h=1.5,$fn=80);

        hull() {
          translate([0,0,-2]) cylinder(r1=threadOD/2+1,
                                        r2=threadOD/2,h=4.5,$fn=80);
          translate([0,0,2.6-wd]) #sphere(r=2.4,$fn=10);
        }

       for(a=[-100,-33,33,100,180]) rotate([0,0,a]) translate([12,0,-8])
          rotate([0,30,0]) scale([1,1,3]) sphere(r=4,$fn=20);

      } // xOff translate
//translate([-100,0,-10]) cube([200,100,100]);
    } // difference
  } // intersection
}

module bottleHolderShell(wd,xOff) {
fr=4;
tr=70-fr;
  union() {
    torous(tr,fr,4);

    for (a=[0:72:358]) hull() {
      translate([tr*cos(a),tr*sin(a),0])
        scale([1,1,2]) sphere(r=2,$fn=16);
      translate([xOff+16*cos(a),16*sin(a),0]) 
        translate([0,0,wd+8])
          scale([1,1,3]) sphere(r=1.5,$fn=16);
      translate([xOff,0,-3]) sphere(r=.3);
    }

    // central main cylinder
    translate([xOff,0,0]) {

       hull() {
         translate([0,0,wd+9]) cylinder(r=threadOD/2+4,h=1,$fn=80);
         translate([0,0,wd-2]) cylinder(r=threadOD/2+5,h=1,$fn=80);
         translate([0,0,  -3]) cylinder(r=2.4,h=1,$fn=80);
       }

    } // xOff translate

  } // union
}
