## RenderingQuality Example

In this example, we show how to change the resolutions involved in an
augmented reality application.

### Screen Resolution

The screen resolution can be changed in the setup(), as shown in
[this file](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/RenderingQuality/RenderingQuality.pde).

If you use a 640x480 pixel camera, the rendering  will be the same
resolution by default. You can make everything look better by increasing
the quality, or speed up your app by decreasing the quality.

### PaperScreen Resolutions

The sizes in PaperScreen are in millimeters, but the rendering has to be in
pixels for the computer. The usual quality is 2x2 pixels per millimeter.
You can change this according to this [example](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/RenderingQuality/SimpleApp.pde).
The `setQuality` code sets the number of pixels per millimeter to use
for this specific `PaperScreen`.

## Examples

### Low Resolution Example
![LowResolution](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/RenderingQuality/lowQuality.jpg "Low Resolution")

### High Resolution Example
![HighResolution](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/RenderingQuality/highQuality.jpg "High Resolution")
