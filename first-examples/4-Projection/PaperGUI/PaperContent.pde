import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

import tech.lity.rea.colorconverter.*;

public class PaperContent  extends PaperTouchScreen {

  Skatolo skatolo;
    //  HoverKnob colorKnob;

  boolean toggle = true;
  int rectColor = 30;

  ColorTracker colorTracker;
  CalibratedStickerTracker stickerTracker;

  void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
  }

  void setup() {
    // Color
    colorTracker = papart.initBlueTracking(this, 1f);
    // Sticker
    stickerTracker = new CalibratedStickerTracker(this, 15);
    // Marker
    initTouchListFromMarkers(333, 345, 40, true);

    // GUI
    skatolo = new Skatolo(this.parent, this);
    skatolo.getMousePointer().disable();
    skatolo.setAutoDraw(false);

    skatolo.addHoverButton("button")
              .setPosition(0, 60)
              .setSize(60, 60);

    skatolo.addHoverToggle("toggle")
              .setPosition(100, 60)
              .setSize(60, 60);


    // colorKnob = new HoverKnob(skatolo, "knob");
    // colorKnob.setRange(0, 255)
    //           .setPosition(180, 40)
    //           .setRadius(50)
    //           .setValue(30);
  }

  void button() {
    if (rectColor >= 255)
    rectColor = 0;
    rectColor += 30;
  }

  void knob() {
      //    rectColor = (int)colorKnob.getValue();
  }


  void drawOnPaper() {
    background(100);

    TouchList allTouchs = new TouchList();

    try{
    /* Getting touchs from multiple sources
    * Comment one to disable it.
    */
    // Mouse
    SkatoloLink.addMouseTo(allTouchs, skatolo, this);
    // Marker
    TouchList markerTouchs = getTouchListFromMarkers();
    allTouchs.addAll(markerTouchs);
    // Stickers
    stickerTracker.findColor(millis());
    TouchList stickerTouchs = getTouchListFrom(stickerTracker);
    allTouchs.addAll(stickerTouchs);
    // Color
    colorTracker.findColor(millis());
    TouchList colorTouchs = getTouchListFrom(colorTracker);
    allTouchs.addAll(colorTouchs);
    // Fingers
    TouchList fingerTouchs = getTouchListFrom(fingerDetection);
    allTouchs.addAll(fingerTouchs);

    // Feed the touchs to Skatolo to activate buttons.
    SkatoloLink.updateTouch(allTouchs, skatolo);
    // Draw the interface
    skatolo.draw(getGraphics());

    drawMarkers(markerTouchs);
    drawPointers();
    // Draw the touch pointers. (debug)
    drawTouch(fingerTouchs);

    } catch(Exception e){
	e.printStackTrace();

    }

    if (toggle) {
      fill(rectColor);
      rect(70, 70, 20, 20);
    }
  }

  void drawPointers() {
    for (tech.lity.rea.skatolo.gui.Pointer p : skatolo.getPointerList()) {
      fill(0, 200, 0);
      rect(p.getX(), p.getY(), 3, 3);
    }
  }

  void drawTouch(TouchList fingerTouchs) {
    fill(255, 0, 20);
    for (Touch t : fingerTouchs) {
      PVector p = t.position;
      ellipse(p.x, p.y, 10, 10);
    }
  }

  void drawMarkers(TouchList markerTouchs) {
    fill(255, 0, 20);
    colorMode(HSB, 10, 100, 100);
    for (Touch t : markerTouchs) {
      pushMatrix();
      translate(t.position.x, t.position.y);
      rotate(t.position.z);
      fill(t.id, 100, 100);
      rect(-10, -10, 20, 20);
      popMatrix();
    }

    colorMode(RGB, 255);
  }
}
