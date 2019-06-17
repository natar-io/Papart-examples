public class PaperContent extends PaperScreen {

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    setDrawOnPaper();
  }

  public void setup() {
  }

  public void drawOnPaper() {
    clear();

    colorMode(HSB, 10, 1, 1);
    background(paperBackgroundColor, 1, 1);

    fill(2, 0.2f, 0.5f);
    rect(10, 20, 100, 75);
  }
}
