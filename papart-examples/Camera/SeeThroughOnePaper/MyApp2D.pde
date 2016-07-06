public class MyApp extends PaperScreen {

  public void settings() {
    // the size of the draw area is 297mm x 210mm.
    setDrawingSize(297, 210);
    // loads the marker that are actually printed and tracked by the camera.
    loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);
    // the application will render drawings and shapes only on the surface of the sheet of paper.
    setDrawOnPaper();
  }

  public void setup() {
  }

  public void drawOnPaper() {
    setLocation(63, 45, 0);
    
    // background: blue
    background(0, 0, 200); 

    // fill the next shapes with green
    fill(0, 100, 0);
    
    // draw a green rectangle
    rect(10, 20, 100, 75);
  }
}