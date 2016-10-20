## Gray Code Scanner

This sketch enables the creation of [structured light scans](https://github.com/potioc/Papart-examples/blob/master/screenshot.png?raw=true)
using grey code. 

## How to use 

This sketch pops-up two window, one is for the projector, the second one is to control the application. 

### First scan

In your camera settings, disable the automatic intensity balance: fix the shutter speed, and gain/sensitivity. 
Use some dimmed projection so that you can clearly see the projected image. The dimmed projection 
will be the value of your `white color`. 

Set the Display time high, to 800 (ms), so that the camera can capture easily the image. Set the caputure time 
accordingly, to 600 (ms). 

Check that your projector is projecting the black window from the sketch and click on the start button. 

Wait for the photos to be taken...  

Once they are taken, you can adjust the decode value, and decode mode (reference or absolute) and hit 
the `decode again` button. If it is properly decoded, you should be able to see an image reconstructed 
from the projector's point of view. You can save it, and it can be then converted to a 3D point cloud. 

Try to get a 3D view of your scan with this [dedicated sketch](https://github.com/potioc/Papart-examples/tree/master/apps/scan3D). 

#### Image of a good scan:

![](https://github.com/potioc/Papart-examples/blob/master/apps/grayCodeConfiguration/screenshot.png?raw=true) 

#### Recovered 3D point cloud:

![](https://github.com/potioc/Papart-examples/blob/master/apps/scan3D/screenshot.png?raw=true)

### Next scans

In the next scans, you can adjust the display time / capture time / delay to get faster scans, and 
adjust the pixel scale to the quality you need. If you have a bad camera (640x480), and a good projector (1920x1080) 
the camera will not differenciate the smaller projections, you can set a high pixel scale: 4 or 5. 
If you have a very good camera and good projector, you can try 1 or 2 as a pixel scale. 

The recovered 3D point cloud will be better if your scan has low noise. It will also be better your 
projector / camera calibration is good. 



### User interface

* DisplayTime: How long an image is projected. 
* CaptureTime: when the image is captured.
* Delay: delay between the image is rendered by the computer, and displayed by the projector. 
* Pixel Scale: 1 to use all the pixels of the camera, 2 to use 1/4th, 3 to use 1/9th and so on. 
* BlackColor: Intensity of the black. 
* WhiteColor: Intensity of the white. 


* Reference: use a frame of reference to find projected pixels. 
* Absolute: use intensity to find projected pixels. 
* Decode Value:  distance from the frame of reference or pixel intensity. 

