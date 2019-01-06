/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   24 March 2017
 * =====================================
 *
 * https://www.thingiverse.com/thing:2200395
 *
 * This is my attempt at creating a predictable
 * helix that can be created from any polygon.
 *
 * It works in a very similar fashion to rotate_extrude,
 * with a height parameter.
 *
 * The height of the final object is equal to the
 * height parameter + the height of the provided polygon.
 *
 */

//
// Usage:
//
// include <helix_extrude.scad>
// helix_extrude()
//     translate([10, 0, 0])
//         circle(r=3);


module helix_extrude(angle=360, height=100) {
	precision = $fn ? $fn : 24;

	// Thickness of polygon used to create an helix segment
	epsilon = 0.001;

	// Number of segments to create.
	//   I reversed ingenering rotate_extrude
	//   to provide a very similar behaviour.
	nbSegments = floor(abs(angle * precision / 360));

	module helix_segment() {
		// The segment is "render" (cached) to save (a lot of) CPU cycles.
		render() {
			// NOTE: hull() doesn't work on 2D polygon in a 3D space.
			//   The polygon needs to be extrude into a 3D shape
			//   before performing the hull() operation.
			//   To work around that problem, we create extremely
			//   thin shape (using linear_extrude) which represent
			//   our 2D polygon.
			hull() {
				rotate([90, 0, 0])
					linear_extrude(height=epsilon) children();

				translate([0, 0, height / nbSegments])
					rotate([90, 0, angle / nbSegments])
						linear_extrude(height=epsilon) children();
			}
		}
	}

	union() {
		for (a = [0:nbSegments-1])
			translate([0, 0, height / nbSegments * a])
				rotate([0, 0, angle / nbSegments * a])
					helix_segment() children();
	}
}

// Module used to create the polygon
// (to make it easier to re-use with rotate_extrude)
module helixPolygon(crest, root, height) {
	retract = (root - crest)/2;
	// Move the trapezoid away from the center
	// translate([axelRadius, 0, 0]) {
		// Simple trapezoid
		polygon([
			[0, 0],
			[height, retract],
			[height, root-retract],
			[0, root]
		]);
	// }
}
