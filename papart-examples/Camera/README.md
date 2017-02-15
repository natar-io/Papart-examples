
#Camera

## First examples
- [SeeThroughOnePaper](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughOnePaper): Simple PapARt application, on paper screen is used for 2D rendering inside it. 
- [SeeThroughWith3DObject](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughWith3DObject): This example shows the **two types** of rendering: **DrawAroundPaper** and **DrawOnPaper**.
- [SeeThroughGUI](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SeeThroughGUI) : the user interface is in  screen space.
- [SeeThroughGUIInsidePaper](https://github.com/poqudrof/Papart-examples/tree/master/papart-examples/Camera/SeeThroughGUIInsidePaper): example of a user interface inside the PaperScreen. 
- Sample application : [SolarSystem](https://github.com/potioc/Papart-examples/tree/master/apps/SolarSystem), 3 paperScreens displaying a 3D model each.

## Handling 3D locations
- [SaveLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/SaveLocation) : Save the 3D location of a PaperScreen to a file. 
- [LoadExternalLocation](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/LoadExternalLocation) : Set the 3D location of a markerboard from a file.
- [RelativeLocations](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/RelativeLocations) : Rendering between two PaperScreens. 

## Rendering quality and performance
- [RenderingQuality](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/RenderingQuality) : rendering quality settings explained, higher quality to remove aliasing or to take full advantage of the hardware or lower quality for better performance.

##Image Analysis Examples
- [ImageExtractionProcessingRendering](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageExtractionProcessingRendering) : The inside of a PaperScreen is extracted and rendered using standard Processing.
- [ImageExtractionSeeThroughRendering](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageExtractionSeeThroughRendering) : Same as above, but rendered inside a PaperScreen.
- [ColorDetectionExample](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ColorDetectionExample) : Select small zone and determine its color.
- [StrokeDetection](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/StrokeDetection): color analysis of a large zone.
- application : [jeuTech](https://github.com/potioc/Papart-examples/tree/master/apps/jeuTech), a physics-based game using touch and color tracking. 

## Utilities
- [ExtractPlanarObjectForTracking](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ExtractPlanarObjectForTracking) : Utility to extract part of an image.
- [GuiCorners](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/GuirCorners): find the 3D location of a 2D object by setting its corners.
- [ImageBasedTracking](https://github.com/potioc/Papart-examples/tree/master/papart-examples/Camera/ImageBasedTracking) : Tracking using natural features instead of markers. Experimental for now. 


#Libraries integration
Done:
- Leap motion [LeapMotionExample](https://github.com/potioc/Papart-examples/tree/master/apps/LeapMotionExample)

Todo:
- optitrack + détection de texte
- graphophone
- programme de calibration de caméra. 
