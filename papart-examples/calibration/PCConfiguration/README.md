# Hardware configuration

This is the sketch to set your hardware configuration. You have to run it to set your hardware 
for the first uses and when your hardware is modified: new camera, projector, or depth camera.

### This is a complement to the [hardware configuration guide](https://github.com/potioc/Papart-examples/wiki/hardware-configuration).

### Projector

This section is subject to change, and for now the only useful part is the `Load Calibration` button, 
with the `Save` buttons. The screen selection, and screen offset sections were for Processing 2.x . They 
are still here because they might be useful on some OS, or future version of Processing. 

#### How to use.

1. Press `Load Calibration`, and select the calibration in `saved/projector-xxx.yaml` with `xxx` as you projector's name.
2. Press `Save as default` to save it. 

If you don't have the calibration for your projector, you can calibrate it with the [intrinsics calibration](https://github.com/potioc/Papart-examples/tree/master/papart-examples/calibration/intrinsicCalibration) 
sketch. 

### Camera

PapARt support many input type, they are listed in the first column. You can try different camera configurations with our [camera test 
sketch](https://github.com/potioc/Papart-examples/tree/master/Tests/CameraTest). It is also possible to try them within this sketch
with the `Test the camera` button. 

### How to use:

1. Press `Load Calibration`, and select the calibration in `saved/camera-xxx.yaml` with `xxx` as you camera's name.
2. Set the `camera description` according to the [[camera guide]]. A good guess is to use a `FFMPEG` video input and 
`/dev/video0` as camera description. The second line is to set options for FFMPEG only. 
3. Press `Save as default` to save it. 


### Kinect / Depth Camera

Here you can select you depth camera, and set its number which is likely to be `0` if you only one plugged. 

## Screenshot


![](https://github.com/potioc/Papart-examples/raw/master/calibration.jpg)
