# Gui and Manual Drawing example

This example demonstrates the manual rendering for see through
augmented reality.


### The ARDisplay

The augmented reality rendering is handled by a `Display`, in this
case it is an `ARDisplay`. This display usually handles the drawing,
but it is possible to do it manually. Here is the code to disable the
automatic drawing:

``` java
  display = papart.getARDisplay();
  display.manualMode();
```

The default drawing code is as following:

``` java
    display.drawScreensOver(); // offscreen rendering
    noStroke();

    // draw the camera image
    if (camera != null && camera.getPImage() != null) {
        image(camera.getPImage(), 0, 0, width, height);
    }
    // draw the AR
    display.drawImage((PGraphicsOpenGL) g, display.render(),
                      0, 0, width, height);
```

### The GUI

In this example, we use a fork of [ControlP5](https://github.com/sojamo/controlp5) called [Skatolo](https://github.com/poqudrof/Skatolo). In this example
both libraries work. Here the GUI is in screen space, Skatolo is used for GUI inside the AR environment.


# Example

![Screenshot](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/SeeThoughGUI/screenshot.jpg)
