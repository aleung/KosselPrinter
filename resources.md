# Software

## Arduino

Install [Arduino IDE](https://www.arduino.cc/)

On Tools menu, select board: MEGA 2560 and port. 

## Firmware

[Marlin](http://marlinfw.org/) firmware for RepRap family printers. ([github](https://github.com/MarlinFirmware/Marlin))

Double click `Marlin/Marlin.ino` file to open project in Arduino IDE.

Config

Calculate key parameters by [Prusa Printers Calculator](https://www.prusaprinters.org/calculator/)：

* `DEFAULT_AXIS_STEPS_PER_UNIT` 

G-code [full list](http://reprap.org/wiki/G-code), [implemented in Marlin](http://marlinfw.org/meta/gcode/)

## Slicer 

Slicers prepare a solid 3D model by dividing it up into thin slices (layers). In the process it generates the G-code base on printer parameters.

* [Slic3r](http://slic3r.org/)

## Printing Host

3D printing host software. Communicate with the printer to control and send G-codes.

* [Printrun](https://github.com/kliment/Printrun) pronterface

## Modeling

* [OpenSCAD](http://www.openscad.org/), programmers solid 3D CAD modeller

## Other Resources

* [Prusa Printer Calculator](https://www.prusaprinters.org/calculator/)

