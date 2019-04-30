import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;

import tech.lity.rea.skatolo.gui.Pointer;

import java.util.Arrays;

public class GUIWithColorExample extends PaperScreen {

  ColorTracker redTracker, blueTracker, customTracker;
  Skatolo skatolo;

  float capQuality = 1.0f;

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
  }

  public void setup() {

    // Using PapARt default color trackers
    redTracker = papart.initRedTracking(this, 1f);
    blueTracker = papart.initBlueTracking(this, 1f);

    // Creating a custom color trackers
    customTracker = createCustomTracker();

    skatolo = new Skatolo(parent, this);
    skatolo.setAutoDraw(false);
    skatolo.getMousePointer().disable();

    skatolo.addHoverButton("onStickerHover")
          .setPosition(123.5, 95)
          .setSize(50, 20)
          .setCaptionLabel("Hover me");
  }

  ColorTracker createCustomTracker() {
    // Number of pixels per millimeter to capture.
    // With capQuality and a zone of 200x100mm you will get
    // 200x100 image analyzed.
    // You can increase or decrease this for better precision vs performance.
    capQuality = 1.0f;

    // The planarTouchCalibration is generic in PapARt here a few parameters are used:
    // MaxDistance: Maximum distance between a colored pixel and the next one.
    // MaxDistanceInit: Maximum distance between a colored pixels and the first one.
    // MinConnectedCompoSize: minimum number of pixels in a color group.
    // More info: fr.inria.papart.multitouch.detection.TouchDetectionColor

    // + Tracking elements:
    // TrackingMaxDist: maximum distance for tracked elements to jump (in millimeter).
    // TrackingForgetTime: maxmim duration of color group after last detection (in millisecond).
    // More info: fr.inria.papart.multitouch.tracking.TrackedElement;

    PlanarTouchCalibration calib = new PlanarTouchCalibration();
    calib.loadFrom(parent, "data/TouchColorCalibration.xml");  // default: Papart.touchColorCalib

    ColorTracker colorTracker = new ColorTracker(this, calib, capQuality);

    // Color parameters are stored in a text file.
    String[] list = parent.loadStrings("data/customThresholds.txt");
    colorTracker.loadParameters(list);
    colorTracker.setName("custom");
    return colorTracker;
  }

  void onStickerHover() {
    //Do stuff on hover
  }

  public void drawOnPaper() {
    clear();
    background(200, 100);

    blueTracker.findColor(millis());
    redTracker.findColor(millis());
    customTracker.findColor(millis());

    TouchList allTouchs = new TouchList();
    allTouchs.addAll(blueTracker.getTouchList());
    allTouchs.addAll(redTracker.getTouchList());
    allTouchs.addAll(customTracker.getTouchList());

    Touch mouse = createTouchFromMouse();
    allTouchs.add(mouse);

    SkatoloLink.updateTouch(allTouchs, skatolo);

    rectMode(CENTER);
    for (Pointer p : skatolo.getPointerList()) {
      fill(0, 255, 0);
      rect(p.getX(), p.getY(), 5, 5);
    }

    skatolo.draw();
  }

  void drawRawDetection(ColorTracker tracker) {
    byte[] found = tracker.getColorFoundArray();
    pushMatrix();
    float sc = 1;
    for (int j = 0; j < drawingSize.y / sc; j++) {
      for (int i = 0; i < drawingSize.x / sc; i++) {
        int offset = j * (int) drawingSize.y + i;
        int v = found[offset];
        if (v != -1) {
          fill(255, 0, 0);
          rect(i, j, 2, 2);
        }
      }
    }
    popMatrix();
  }
}
