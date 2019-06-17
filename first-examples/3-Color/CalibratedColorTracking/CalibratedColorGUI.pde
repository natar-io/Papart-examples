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

public class CalibratedColorGUI extends PaperScreen {
  CalibratedColorTracker colorTracker;
  Skatolo skatolo;

  // Number of pixels per millimeter to capture.
  // With capQuality and a zone of 200x100mm you will get
  // 200x100 image analyzed.
  // You can increase or decrease this for better precision vs performance.
  float capQuality = 0.5f;

  void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
  }

  void setup() {
    colorTracker = new CalibratedColorTracker(this, capQuality);

    skatolo = new Skatolo(parent, this);
    skatolo.setAutoDraw(false);
    skatolo.getMousePointer().disable();

    skatolo.addHoverButton("onStickerHover")
          .setPosition(123.5, 95)
          .setSize(50, 20)
          .setCaptionLabel("Hover me");
  }

  public void drawOnPaper() {
    clear();
    background(200, 100);

    ArrayList<TrackedElement> coloredElements = colorTracker.findColor(millis());

    pushStyle();
    for (TrackedElement coloredElement : coloredElements) {
      int c = colorTracker.getReferenceColor(coloredElement.attachedValue);
      stroke(0);
      strokeWeight(1);
      fill(red(c), green(c), blue(c));
      rectMode(CENTER);
      rect(coloredElement.getPosition().x, coloredElement.getPosition().y, 5, 5);
    }
    popStyle();

    TouchList touchs = new TouchList();
    touchs.addAll(colorTracker.getTouchList());
    SkatoloLink.updateTouch(touchs, skatolo);

    skatolo.draw();
  }
}
