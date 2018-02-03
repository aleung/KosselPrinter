W_BD = 10.8;
W_DF = 17.2;
W_BF = W_BD + W_DF;
echo(W_BF=W_BF);

W_AB = 5;
W_BC = 4;

W_AC = W_AB + W_BC;
W_AD = W_AB + W_BD;
W_AF = W_AB + W_BF;
W_CE = W_BF - W_BC * 2;
echo(W_CE=W_CE);

W = W_BF + 2 * W_AB;
echo(W=W);

H = 11;
D = 5.5;

D_M3 = 6.8;  


module hole(h, d, x_offset, z_offset=0, fn=12) {
    translate([x_offset, 0, z_offset]) cylinder(h=h, d=d, $fn=fn);    
}

module bump(x, y, z) {
    color("red")
        translate([x, y-1, z+1.5/2])
            cube([6, 2, 1.5], center=true);
}

difference() {
    translate([0, -H/2, 0]) cube([W, H, D]);
    hole(D, 3, W_AB);
    hole(D, D_M3, W_AB, 4, 6);
    hole(D, 3, W_AF);
    hole(D, D_M3, W_AF, 4, 6);
    hole(D, 3, W_AD);
    hole(3.5, 6, W_AD);
    translate([W_AC, -H/2, 0]) cube([W_CE, H, 2]);
}

bump(W_AD, H/2, D);
mirror([0,1,0]) bump(W_AD, H/2, D);
