/* A candlestick, to show off spline_lathe.
*/

use <../spline.scad>
include <../dfm.scad>

CANDLE_WIDTH = 22;

SOCKET_DEPTH = CANDLE_WIDTH;
SOCKET_RADIUS = (CANDLE_WIDTH + SLIDE_FIT) / 2;

BASE_RADIUS = SOCKET_RADIUS * GOLDEN;

NECK_RADIUS = max(3, SOCKET_RADIUS * 0.3);
NECK_HEIGHT = SOCKET_RADIUS;

CUP_HEIGHT = BASE_RADIUS * GOLDEN;

WALL = 2;
intersection() {
cube([50,50,80]);
//spline_lathe([
spline_pot([
  [BASE_RADIUS, 0], [BASE_RADIUS, 2], 

  [NECK_RADIUS, NECK_HEIGHT],

  // outside of socket
  [SOCKET_RADIUS + WALL + 1, CUP_HEIGHT], 
  [SOCKET_RADIUS + WALL, CUP_HEIGHT + SOCKET_DEPTH / GOLDEN], 
  [SOCKET_RADIUS + WALL + 1, CUP_HEIGHT + SOCKET_DEPTH],

  // inside of socket
  [SOCKET_RADIUS, CUP_HEIGHT + SOCKET_DEPTH], 
  [SOCKET_RADIUS, CUP_HEIGHT]
  ], 
  $fn=60);
}