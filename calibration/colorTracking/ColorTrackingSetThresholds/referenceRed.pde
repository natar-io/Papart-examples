int redColor = 0;
int blueColor = 0;

float referenceSize = 3; // in mm 

// Red Detection, it outputs the redColor as a reference. 
public class ColorReference extends PaperScreen {

  public void settings() {
      setDrawingSize(210, 192);
    //    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 280, 210);
      // loadMarkerBoard(Papart.markerFolder + "ExtractedView.bmp", 210, 192);
      loadMarkerBoard(Papart.markerFolder + "color.svg", 210, 192);
  }
    ColorDetection redDetection, blueDetection;

  public void setup() {
    redDetection = new ColorDetection(this);
    redDetection.setCaptureSize(referenceSize, referenceSize);
    redDetection.setPosition(new PVector(25, 80));
    redDetection.init();

    blueDetection = new ColorDetection(this);
    blueDetection.setCaptureSize(referenceSize, referenceSize);
    blueDetection.setPosition(new PVector(80, 80));
    blueDetection.init();
  }

  public void drawOnPaper() {
    background(200, 100);
    //    redDetection.setPosition(new PVector(30, 15));

    // redDetection.drawSelf();
    redDetection.computeColor();
    redDetection.drawCaptureZone();
    redColor = redDetection.getColor();

    //    blueDetection.drawSelf();
    blueDetection.computeColor();
    blueDetection.drawCaptureZone();
    blueColor = blueDetection.getColor();
  }
}
