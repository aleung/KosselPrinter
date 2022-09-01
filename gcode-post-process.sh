#!/bin/sh

# Stop bed heating before finsih
/usr/local/bin/sed -i 's/M117 Time Left 0h4m0s/M140 S0/' $1
/usr/local/bin/sed -i 's/M117 Time Left 0h4m1s/M140 S0/' $1
/usr/local/bin/sed -i 's/M117 Time Left 0h4m2s/M140 S0/' $1
/usr/local/bin/sed -i 's/M117 Time Left 0h4m3s/M140 S0/' $1
