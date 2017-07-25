# Plane Set Calibration

This applications calibrates the kinect by setting the 3D position of the planar surface you want to make tactile (that can be a computer screen, a desk, wall...).

# How to use

![interface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/calibration/PlaneSetCalibration/planesetcalibration_interface.png)

The interface contains a slider `PlaneUP` (top left), a toggle button `use Marker` (left) and a `Save` button (bottom left).
You can also see 4 draggables items that should be dragged to represent the four angles of the tactile area.

There are two modes: a mode using only the color camera feed, and a mode displaying the depth data from the kinect with color added. Use the toggle button UseAR to switch between modes.

**Important**: We recommend to choose the mode depending on physical and luminosity parameters: for example the Kinect Depth Mode is not very performant with black and transparent materials (materials not seen by the depth camera) ; whereas the AR mode uses the color camera and adds depth data above it so it can be used to set touch on a black screen for example.

We recommend to use the Kinect depth mode in these cases:
* Table (like in the pictures here). 
* Large area like walls. 

We recommend the `Marker` moder in these cases:
* TouchScreen, as screens are usually badly analysed by the depth camera.
* Table: more precise than the previous case. 
* Any high precision touch or when depth is not viewed. 


##Kinect Depth Mode

![interface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/calibration/PlaneSetCalibration/planesetcalibration_depth.png)

The kinect depth mode shows the depth data coming from the kinect with color informations added.

Use the slider to calibrate: you must see the objects **above** the plane coloured. 
The calibration plane is set by the points you place. It uses the depth data from the depth camera. 

##Augmented Reality Mode 

**Important**: You have to print the file: `sketchbook/libraries/PapARt/data/markers/big-calib.svg` in A3 format.

![interface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/calibration/PlaneSetCalibration/planesetcalibration_ar.png)

In this mode we only display the color camera feed, and the depth data inside the calibration rectangle. 
The calibration plane is set by the A3 sheet you printed. 

Use the slide bar to calibrate the kinect: usually the planar surface you want to configure for tactile interaction is red, and the 3D items above it are whiter. 


Below is an example of a bad calibration: the surface is not totally colored. 

![interface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/calibration/PlaneSetCalibration/planesetcalibration_ar_bad.png)


##Saving

When you are done calibrating the height of your tactile surface, you can press the `Save` button.
