## SeeThroughWith3D

In this example we show the difference between two functions: `setDrawOnPaper`
and `setDrawAroundPaper`.

### DrawOnPaper - PaperScreen2D

When you use `setDrawOnPaper` a virtual screen is created and the
rendering is done inside this virtual screen.

It is showed at the bottom of the picture.

The resolution used is the PaperScreen resolution (see the [Resolution example](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/RenderingQuality)).


### DrawOnPaper - PaperScreen3D

When you use `setDrawAroundPaper` the rendering is done in the
global augmented reality rendering buffer. The point of view of the
rendering is placed at the camera's location, as you can seen in the top
part of the screenshot.

Try to place a background()
instruction in a `DrawAroundPaper` to see the difference with the other
type of rendering.

The resolution used is the screen resolution (see the [Resolution example](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/RenderingQuality)).


![HighResolution](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/SeeThroughWith3DObject/screenshot.png "Screenshot 2D and 3D rendering.")
