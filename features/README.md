## Advanced uses and features

### Scan 3D
* With a ProCam system you can do 3D scanner with the Scanner3D apps. 

### External integrations

There are a few example of third party integrations: Leap Motion, Tuio output, and OCR via Tesseract.

### Advanced uses

#### Handling 3D locations
- [SaveLocation](SaveLocation) : Save the 3D location of a PaperScreen to a file. 
- [LoadExternalLocation](LoadExternalLocation) : Set the 3D location of a markerboard from a file.
- [RelativeLocations](RelativeLocations) : Rendering between two PaperScreens. 

#### Rendering quality and performance
- [RenderingQuality](RenderingQuality) : rendering quality settings explained, higher quality to remove aliasing or to take full advantage of the hardware or lower quality for better performance.

#### Image Analysis Examples
- [ImageExtractionProcessingRendering](ImageExtractionProcessingRendering) : The inside of a PaperScreen is extracted and rendered using standard Processing.
- [ImageExtractionSeeThroughRendering](ImageExtractionSeeThroughRendering) : Same as above, but rendered inside a PaperScreen.
- [ColorDetectionExample](ColorDetectionExample) : Select small zone and determine its color.
- [StrokeDetection](StrokeDetection): color analysis of a large zone.
- application : [jeuTech](https://github.com/poqudrof/Papart-examples/tree/master/apps/jeuTech), a physics-based game using touch and color tracking. 
- [ImageBasedTracking](ImageBasedTracking) : Tracking using natural features instead of markers. Experimental for now. 

