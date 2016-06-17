public class MyApp extends PaperScreen {

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(sketchPath() + "ExtractedView.bmp", 150, 105);
    setDrawOnPaper();
  }

  public void setup() {
  }

  public void drawOnPaper() {
    setLocation(63, 45, 0);
    // background of the sheet is blue
    background(0, 0, 200); 

    fill(0, 100, 0);
    // add a green rectangle
    rect(10, 20, 100, 75);
  }
}