function main() {
  return union([
    linear_extrude({height:4}, polygon([[0,0], [15, 0], [15, 13], [0, 7]])),
    linear_extrude({height:2}, polygon([[15, 13], [12, 16], [0, 11], [0, 7]])),
    linear_extrude({height:4.7}, polygon([[0,4], [15, 4], [15, 10], [7.5, 10], [0, 7]])),
  ]).subtract(cylinder({d: 3.2, h: 5, fn:36}).translate([10, 7]));
}