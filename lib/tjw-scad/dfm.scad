/* Design For Manufacture (DFM) constants.
  Include it using: include <tjw-scad/dfm.scad>
  Use these to allow others to easily modify your designs to work well on their own printers,
  or to port your own designs to your next printer!
*/

// ===========================================================================
// Settings to customize per printer

// The size of the printer's nozzle.
NOZZLE = 0.50;

// The layer height setting you're using to print.
NOMINAL_LAYER = 0.2;

// The nominal height of the first layer printed, often different from the rest.
NOMINAL_FIRST_LAYER = 0.3;

// The steepest angle, in degrees from +Z, that your printer can print.
// The maximum overhang angle.
MAX_OVERHANG_ANGLE =
  //45;  // fairly conservative universal value
  60;  // not impossible if you have a layer fan and it hits the geometry well


// ===========================================================================
// Universal constants

// Use this to ensure that Boolean edges aren't coincident.
EPSILON = 0.01;
EPSILON2 = [EPSILON, EPSILON];
EPSILON3 = [EPSILON, EPSILON, EPSILON];

// Handy constant for when you want something big, and it doesn't matter how big.
// Often used in Boolean subtraction.
HUGE = 1000;

// The "Golden Ratio," AKA golden mean or divine proportion, 
// possibly overhyped but you could do worse as a relative size for nice forms.
GOLDEN = 1.618;

// Use like "THUMB = 1*inch;"
inch = 25.4;

PI = 3.1415629;

// ===========================================================================
// Derived settings that you may not need to customize

// Use this in calculations where you need something to be the minimum possible height.
SINGLE_LAYER = NOMINAL_LAYER + EPSILON;

// The first layer is usually thicker to promote good bonding with the build plate.
// So, if you something a single layer tall, and it's the bottom layer, use this.
FIRST_LAYER = NOMINAL_FIRST_LAYER + EPSILON;
// But that may not be enough to actually get it to appear from the slicer,
// so to produce a single first layer output, use this.
MIN_THICKNESS_FIRST_LAYER = NOMINAL_FIRST_LAYER;

// The minimum horizontal thickness for something to get printed - a vertical wall, e.g.
MIN_WALL_THICKNESS = NOZZLE * 1.04;
MIN_WALL_THICKNESS_FIRST_LAYER = NOZZLE + MIN_THICKNESS_FIRST_LAYER;

// If you want a dimension to be the same horizontally and vertically,
// this is the minimum thickness for printing.
MIN_THICKNESS = max(MIN_WALL_THICKNESS, MIN_THICKNESS_FIRST_LAYER, MIN_WALL_THICKNESS_FIRST_LAYER);

// This is the total delta between surfaces for different degrees of fit.
// The main constant in each group is sized for things that slide freely between two walls; 
// if you have something that is fixed in the middle between two walls, use _FIXED.
// And for structures that are fixed and have only one gap, use _SINGLE.
LOOSE_FIT = 1.2;  // Extra sloppy - for things that need some slack to insert.
LOOSE_FIT_FIXED = LOOSE_FIT + 0.2;
LOOSE_FIT_SINGLE = LOOSE_FIT / 2;

SLIDE_FIT = 0.6;  // Close enough to slide well without getting crooked.
SLIDE_FIT_FIXED = SLIDE_FIT * 2;
SLIDE_FIT_SINGLE = SLIDE_FIT / 2;

FRICTION_FIT = 0.4;  // Close enough to require some force, and then stick.
FRICTION_FIT_FIXED = 0.6;
FRICTION_FIT_SINGLE = 0.3;

// ===========================================================================
// Circles that need to rotate generally need more clearance,
// because of irregularities in different axes of the printer,
// and because of faceting in the model.

CIRCLE_FIT = 0.2;

LOOSE_CIRCLE_FIT = LOOSE_FIT + CIRCLE_FIT;
SLIDE_CIRCLE_FIT = SLIDE_FIT + CIRCLE_FIT;
FRICTION_CIRCLE_FIT = FRICTION_FIT + CIRCLE_FIT;

// ===========================================================================
// These are features of the material used.
// These settings are my general favorites for PLA.

// The thickness of something to be printed just for support.
SUPPORT_WIDTH = MIN_THICKNESS;

// A good thickness for something that should flex, but be strong.
// Ends up being a couple of layers at 0.2 mm layer height.
STRONG_FLEX = 0.45;

// A good minimum thickness for something that should be quite rigid.
RIGID_WALL = 1.2;
  
THICK_WALL = 2;
