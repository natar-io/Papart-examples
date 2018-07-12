import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;
import tech.lity.rea.colorconverter.*;
import org.openni.*;
import java.util.Arrays;

public class MyApp extends PaperScreen {

  ColorTracker colorTracker;
  CalibratedColorTracker calibratedColorTracker;
  Skatolo skatoloInside;

  int w = 128;
  int h = 128;
  public void settings() {
    setDrawingSize(w, h);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 
      w, h);
  }

    
    float capQuality = 1f;

  public void setup() {

      colorTracker = createBlueTracking();

      // Using PapARt calibrations.
      // colorTracker = papart.initBlueTracking(this, capQuality);
      // colorTracker = papart.initRedTracking(this, 1/capQuality); //0.5f);
      
    skatoloInside = new Skatolo(parent, this);
    skatoloInside.setAutoDraw(false);
    skatoloInside.getMousePointer().disable();

    skatoloInside.addHoverButton("hover")
      .setPosition(60, 60)
      .setSize(30, 30);
  }

    ColorTracker createBlueTracking(){


	// Number of pixels per millimeter to capture. 
	// With capQuality and a zone of 200x100mm you will get
	// 200x100 image analyzed.
	// You can increase or decrease this for better precision vs performance.
	capQuality = 0.5f;

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
	String[] list = parent.loadStrings("data/blueThresholds.txt");
        colorTracker.loadParameters(list);
        colorTracker.setName("blue");
	return colorTracker;
    }
    

  void hover() { 
    println("Hover activ");
  }

  public void drawOnPaper() {
    try {

      setLocation(new PVector(40, 40));
      // println("FrameRate" + frameRate);
      background(200, 100);
      ArrayList<TrackedElement> te = colorTracker.findColor(millis());
      TouchList touchs = colorTracker.getTouchList();

      // Touch mouse = createTouchFromMouse();
      // touchs.add(mouse);
      noStroke();

      drawRawData();
      drawTouchData(te);

      SkatoloLink.updateTouch(touchs, skatoloInside); 

      //      drawPointerData();
      // draw the GUI.
      skatoloInside.draw(getGraphics());
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }


  void drawPointerData() {
    for (tech.lity.rea.skatolo.gui.Pointer p : skatoloInside.getPointerList()) {
      fill(200, 20, 0, 180);
      rect(p.getX(), p.getY(), 8, 8);
    }
  }

  void drawTouchData(ArrayList<TrackedElement> te) {
    for (TrackedElement t : te) {
      fill(200, 150);
      PVector p = t.getPosition();
      //println("Tracked Element " + p);
      ellipse(p.x, p.y, 5, 5);
    }
  }

  void drawRawData() {
    byte[] found = colorTracker.getColorFoundArray();

    pushMatrix();
    fill(20, 255, 10, 180);
    scale(1f/capQuality);
    for (int j = 0; j < drawingSize.y *capQuality; j++) {
      for (int i = 0; i < drawingSize.x * capQuality; i++) {

        int offset = j * (int) (drawingSize.y *capQuality) + i;

        if (offset >= found.length) {
          continue;
        }
        //int v = found[k++];
        int v = found[offset];
        if (v != -1) {
          rect(i, j, 2, 2);
        }
      }
    }
    popMatrix();
  }
}
