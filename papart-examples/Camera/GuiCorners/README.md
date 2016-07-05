# Interface avec angles draggables pour définir la position manuelle des marqueurs

In this example we want to save a 3D position of a planar object. The position is manually set by user.

## Inputs
First the user enters the real size of the object in the corresponding inputs in the top left hand corner (see bellow). He has to press **change mode** button to make the changes effective.

![Setting the objects' size](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/GuiCorners/guicorners_size.png)

Once those parameters are set, the user can arrange the shape of the 3D position he wants to record.
The 1st corner is selected, and he can drag it on the corner of the real image. Then he can press the 2 key and grab the second corner and set it where he wants, and so on.

![Arrange the corners](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/GuiCorners/guicorners_drag.png)

## Buttons
###Orientation
Anytime the user can arrange the axis thus the orientation of the 3D position, by clicking on the corresponding buttons.

For exemple, we can see bellow that the user wanted to have the Y-Axis going towards the top of the image, so he pressed the **change Y axis** button.

![Changing axis](https://github.com/potioc/Papart-examples/blob/master/papart-examples/Camera/GuiCorners/guicorners_axis.png)
###Save
When the orientation and the position of the shape is correct, the user can press the **save** button and the position is saved in the marker.xml file, contained in the solution folder.

###Size
If he wants to change the object saved, the user can press **change mode** button and enter new sizes.
