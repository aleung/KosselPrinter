# tjw-scad
My reusable additions to OpenSCAD.
https://github.com/teejaydub/tjw-scad

## Installation 
Put the files somewhere accessible to your OpenSCAD installation.  I use a subfolder called `tjw`.

## Overview
See the comments within the modules for usage details.  Current contents:

* *arrange* - Easily arrange duplicates of a given object or many objects in two or three dimensions.
* *dfm* - Design For Manufacturing - has a ton of constants to use in your designs when some dimension depends on your printer's capabilities.
* *moves* - Mostly for readability, like `moveUp(4) cube(2)`.
* *spline* - Draw smooth spline curves through a list of points, and make surfaces from them.
  - 2D
    * spline_ribbon
  - 3D
    * spline_ramen - 实心圆管
    * spline_hose - 空心园管
    * spline_sausage - 香肠（两端半球形的圆管）
    * spline_udon - 方条
    * spline_pot - 花瓶，由插值曲线旋转一周而成
    * spline_lathe - 花瓶，由插值曲线旋转一周而成，内部填充实心