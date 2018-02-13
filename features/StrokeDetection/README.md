#Stroke detection using color detection

This example shows how to use the color detection in a TrackedView.

![Screenshot](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/StrokeDetection/strokedetection.png)

## TrackedView

The paperscreen is divided in two parts : the right part of the screen is a tracked view that consists in a view that you can record and work on the captured image.

On the left is a rendering screen. In this example it is used to display the pixels we have detected that fit the color detection, in the tracked view.


In the bottom right hand corner, there is a dark blue square. This 20x20mm square is the zone where color is detected. Thus, every pixel in the tracked view that match the dark blue color is detected and displayed in red in the render screen. 
The ellipse in a real-time indicator that represent the color you are trying to detect.

Another example of the application:

![Screenshot](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/StrokeDetection/strokedetection2.png)
