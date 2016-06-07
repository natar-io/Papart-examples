# SolarSystem
 
This application uses the same logic as in [SeeThroughOnePaper](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/PaperApp2D) but uses several sheets of paper with different markers.
 
## Files
 
The main file [planetes.pde](https://github.com/potioc/Papart-examples/blob/master/apps/planetes/planetes.pde) is almost the same as in SeeThroughOnePaper, plus a fiew variables for scaling the objects together. 
 
There is also one sketch per object you want to render, for example we have here `earth.pde`, `moon.pde` and `sun.pde`. 
They match exactly the markers we printed ; in this situation : **one object rendered equals one `.svg` file and one `.pde` file**.
 
Each sketch file contains :
- `setup()` and `settings()` methods
- a `drawAroundPaper()` method
- some variables
 
We use the `drawAroundPaper()` method because of the size of the objects rendered : the `drawOnPaper()` method is only used when you want your objects to be displayed in a specific canvas. Here the sun is larger than the marker sheet so we have to draw it on the outside of the PaperScreen too.
 
## Markers
 
Below are the sheets of paper with the markers used for each object in the solar system you want to display. You can have as many as you want, as long as they are all in the tracking field of the Papart Camera.
 
![Solar System markers](https://github.com/potioc/Papart-examples/blob/master/apps/planetes/solar_system_markers.jpg)
 
## Rendering
 
Here is the result : each sheet of paper renders its solar system object.
 
![Solar System rendering](https://github.com/potioc/Papart-examples/blob/master/apps/planetes/solar_system.jpg)
