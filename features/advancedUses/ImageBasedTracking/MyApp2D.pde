public class MyApp extends PaperScreen {

  public void settings() {
      // size of the virtual screen
      setDrawingSize(297, 210);
      //    loadMarkerBoard(sketchPath() + "/ExtractedView.bmp", 285, 200); 
    // printed image size in millimeters
      loadMarkerBoard(sketchPath() + "/ExtractedView.bmp", 90, 50);
    setDrawOnPaper();
  }

  public void setup() {
  }

  public void drawOnPaper() {
    setLocation(0, 0, 0);
    background(0, 0, 200, 100);
    fill(0, 100, 0);
    rect(10, 20, 100, 75);
  }
}
