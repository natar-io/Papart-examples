import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.calibration.files.*;
import org.openni.*;
import java.util.Arrays;

public class MyApp extends PaperScreen {

  TrackedView boardView;

  ColorDetection colorDetectionInk;

  PVector captureSize;
  PVector origin = new PVector(0, 0);
  PVector captureSizePx = new PVector(200, 100);
  byte[] colorFoundArray;
  TouchDetectionColor touchDetectionColor ;
  ArrayList<TrackedElement> trackedColors = new ArrayList<TrackedElement>();

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
  }

  public void setup() {
    boardView = new TrackedView(this);

    captureSize = new PVector(drawingSize.x / 2, drawingSize.y);
    boardView.setCaptureSizeMM(captureSize);

    boardView.setImageWidthPx((int) captureSizePx.x);
    boardView.setImageHeightPx((int) captureSizePx.y);

    boardView.setTopLeftCorner(origin);

    boardView.init();

    colorDetectionInk = new ColorDetection((PaperScreen) this);
    colorDetectionInk.setCaptureSize(20, 20);
    colorDetectionInk.setPosition(new PVector(10, 50));
    colorDetectionInk.initialize();

    touchDetectionColor = new TouchDetectionColor(new SimpleSize(captureSizePx));
    colorFoundArray = touchDetectionColor.createInputArray();

    PlanarTouchCalibration calib = new PlanarTouchCalibration();
    calib.loadFrom(parent, "TouchColorCalibration.xml");
    touchDetectionColor.setCalibration(calib);
  }

  int paperColor, inkColor;
  PImage capturedImage;

  public void drawOnPaper() {
    clear();

    capturedImage = boardView.getViewOf(cameraTracking);
    colorDetectionInk.computeColor();

    // Debug
    // colorDetectionPaper.drawSelf();
    // colorDetectionInk.drawSelf();

    colorDetectionInk.drawCaptureZone();

    inkColor = colorDetectionInk.getColor();

    if (capturedImage == null)
      return;

    drawCaptureZone();
    drawCapturedImage(capturedImage);


    findColorRegions();
  }

  void drawCaptureZone() {
    stroke(100);
    noFill();
    strokeWeight(2);
    rect((int) origin.x, (int) origin.y, 
      (int) captureSize.x, (int)captureSize.y);
  }

  void drawCapturedImage(PImage img) {
    image(img, 
      (int) origin.x, (int) origin.y, 
      captureSize.x, captureSize.y);
  }

  float dx, dy;

  void findColorRegions() {
    int highLightColor = color(0, 204, 0);
    int hideColor = color(96, 180);

    capturedImage.loadPixels();
    pushMatrix();
    translate(origin.x, origin.y);

    noStroke();
    fill(highLightColor);

    dx = (captureSize.x / captureSizePx.x);
    dy = (captureSize.y / captureSizePx.y);

    // Reset the colorFoundArray
    touchDetectionColor.resetInputArray();

    for (int x=0; x < capturedImage.width; x++) {
      for (int y=0; y < capturedImage.height; y++) {
        int offset = x + y * capturedImage.width;
        fill(highLightColor);

        boolean valid = highlightCorrectRegion(offset, x, y);
        if (valid) {
          // Note the point as valid. 0 is first component.
          colorFoundArray[offset] = 0;
        }
      }
    }

    popMatrix();

    // the array is ready. let's find the components.
    ArrayList<TrackedElement> trackedElements =
      touchDetectionColor.compute(millis(), erosionAmount);
    TouchPointTracker.trackPoints(trackedColors, trackedElements, 
      millis());

    fill(0, 0, 255);
    //      println("Tracking result: "+ trackedColors.size());
    for (TrackedElement te : trackedColors) {
      float x = te.getPosition().x;
      float y = te.getPosition().y;

      PVector p = boardView.pixelsToMM(te.getPosition());
      rect(p.x, p.y, 10, 10);
    }
  }

  boolean highlightCorrectRegion(int offset, int x, int y) {    
    // float hueThresh = 40;
    // float satThresh = 60;
    // float brightThresh = 40;
    boolean good = MathUtils.colorFinderHSB(getGraphics(), 
      inkColor, capturedImage.pixels[offset], 
      threshHue, 
      threshSat, 
      threshIntens);

    boolean red = MathUtils.isRed(getGraphics(), 
      inkColor, capturedImage.pixels[offset], 
      (int) redThresh);
    boolean blue = MathUtils.isBlue(getGraphics(), 
      inkColor, capturedImage.pixels[offset], 
      (int) blueThresh);

    boolean black = MathUtils.isBlack(getGraphics(), 
      capturedImage.pixels[offset], 
      blackThresh);

    // boolean good = MathUtils.colorDistHSBAutoThresh(getGraphics(),
    // 				      inkColor, capturedImage.pixels[offset],
    // 				      threshGlobal);

    if (good && !black && red && blue) {
      float drawX = (x / captureSizePx.x) * captureSize.x;
      float drawY = (y / captureSizePx.y) * captureSize.y;
      rect(drawX, drawY, dx, dy);

      return true;
    }
    return false;
  }
}
