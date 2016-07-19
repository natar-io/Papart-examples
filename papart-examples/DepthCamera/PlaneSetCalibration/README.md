# Plane Set Calibration

This applications calibrates the kinect by setting the 3D position of the planar surface you want to make tactile (that can be a computer screen, a desk, wall...).

# How To
![interface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/DepthCamera/PlaneSetCalibration/planesetcalibration_interface)

The interface contains a slider PlaneUP (top left), a toggle button UseAR (left) and a Save button (bottom left).
You can also see 4 draggables items that should be dragged to represent the four angles of the calibration sheet.

There are two modes: a mode using only the color camera feed, and a mode displaying the depth data from the kinect with color added. Use the toggle button UseAR to switch between modes.

**Important**: We recommend to choose the mode depending on physical and luminosity parameters: for example the Kinect Depth Mode is not very performant with low luminosity and black materials (but it reflects more of a real set of depth data) ; whereas the AR mode uses the color camera and adds depth data above it so it can be used to set touch on black screens for example.

##Augmented Reality Mode 

![interface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/DepthCamera/PlaneSetCalibration/planesetcalibration_ar)

In this mode we only display the color camera feed, and the depth data inside the calibration rectangle. You can put any 3D object on the calibration sheet to compare heights between the planar surface and items above it. 
Use the slide bar to calibrate the kinect: usually the planar surface you want to configure for tactile interaction is red, and the 3D items above it are whiter. 

Below is an example of a bad calibration: the surface is not totally red so the system can be confused between 3D objects and the planar surface.

![interface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/DepthCamera/PlaneSetCalibration/planesetcalibration_ar_bad)


##Kinect Depth Mode

![interface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/DepthCamera/PlaneSetCalibration/planesetcalibration_depth)

The kinect depth mode shows the depth data coming from the kinect (with color informations added).

Use the slide bar to calibrate: the proper set is when the rectangle just start to be colored (see picture above).
