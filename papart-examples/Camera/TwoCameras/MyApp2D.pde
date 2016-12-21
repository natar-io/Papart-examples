public class MyApp extends PaperScreen {

  public void settings() {
    // the size of the draw area is 297mm x 210mm.
    setDrawingSize(297, 210);
    // loads the marker that are actually printed and tracked by the camera.
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);

    // the application will render drawings and shapes only on the surface of the sheet of paper.
    setDrawOnPaper();
  }

  public void setup() {
  }

  public void drawOnPaper() {

    background(0, 0, 20, 100);
    
      // setLocation(63, 45, 0);
      camera2.grab();
      PImage im = camera2.getPImage();
      if(im != null){
	  image(im, 0, 0, drawingSize.x, drawingSize.y);
      }

  }
}
