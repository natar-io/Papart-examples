# SeeThroughOnePaper
 
This application shows how to use a camera to track markers on a surface and render objects in your computer screen.
 
##First file: SeeThroughOnePaper
The `settings()` method indicates how to render your processing app. Here we ask for a fullscreen application :  `fullScreen(P3D);`.
 
The `setup()` method contains the important variable `Papart papart`, loads the other files in the solution ([MyApp2D](https://github.com/potioc/Papart-examples/edit/master/papart-examples/Camera/SeeThroughOnePaper/PaperApp2D.pde)) and starts to track markers.
 
##Second file: MyApp2D
Markers are loaded in the `settings()` method, from a SVG file using this command `loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);`.

Objects can be added to the PaperScreen in the `drawOnPaper()` method, such as `rect(10, 20, 100, 75);` instructions.
 
# Example
 
Below are the markers you can put on any planar surface, as long as your camera can track them.
 
![Markers on any surface](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/SeeThroughOnePaper/markers.jpg)
 
In the computer screen, several objects (blue and green rectangles) are rendered in the PaperScreen application. The image is from the camera point of view.
 
![Result in computer screen](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/SeeThroughOnePaper/screen_rendering.jpg)
