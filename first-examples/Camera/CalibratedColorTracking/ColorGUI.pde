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

  float sc = 0.5f;

  public void setup() {

    // colorTracker = papart.initRedTracking(this, 1/sc); //0.5f);
    colorTracker = papart.initBlueTracking(this, sc);

    skatoloInside = new Skatolo(parent, this);
    skatoloInside.setAutoDraw(false);
    skatoloInside.getMousePointer().disable();

    skatoloInside.addHoverButton("hover")
      .setPosition(60, 60)
      .setSize(30, 30);
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

      drawPointerData();
      // draw the GUI.
      skatoloInside.draw(getGraphics());
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }


  void drawPointerData() {
    for (tech.lity.rea.skatolo.gui.Pointer p : skatoloInside.getPointerList()) {
      fill(200, 0, 0, 140);
      rect(p.getX(), p.getY(), 2, 2);
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
    scale(1f/sc);
    for (int j = 0; j < drawingSize.y *sc; j++) {
      for (int i = 0; i < drawingSize.x * sc; i++) {

        int offset = j * (int) (drawingSize.y *sc) + i;

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
