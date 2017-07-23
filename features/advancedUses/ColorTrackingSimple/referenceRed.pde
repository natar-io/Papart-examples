int redColor = 0;

// Red Detection, it outputs the redColor as a reference. 
public class ColorReference extends PaperScreen {

  public void settings() {
    setDrawingSize(280, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 280, 210);
  }
  ColorDetection redDetection;

  public void setup() {
    redDetection = new ColorDetection(this);
    redDetection.setCaptureSize(20, 20);
    redDetection.setPosition(new PVector(0, 0));
    redDetection.init();
  }

  public void drawOnPaper() {
    background(200, 100);
    redDetection.setPosition(new PVector(30, 15));
    redDetection.drawSelf();
    redDetection.computeColor();
    redDetection.drawCaptureZone();
    redColor = redDetection.getColor();
  }
}