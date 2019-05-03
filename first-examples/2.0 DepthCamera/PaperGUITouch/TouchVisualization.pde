import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;
import java.util.ArrayList;
import toxi.geom.Vec3D;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;

public class TouchVisualization  extends PaperTouchScreen {

  Skatolo skatolo;

  void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    setQuality(3f);
  }

  void setup() {
    skatolo = new Skatolo(this.parent, this);
    skatolo.getMousePointer().disable();
    skatolo.setAutoDraw(false);

    skatolo.addHoverButton("button")
    .setPosition(0, 0)
    .setSize(60, 60);

    skatolo.addHoverToggle("toggle")
    .setPosition(100, 0)
    .setSize(60, 60);
  }

  boolean toggle = false;

  void button() {
    println("button pressed");
    println("Toggle value " + toggle);
  }

  void drawOnPaper() {
    background(100, 100);

    TouchList fingerTouchs = getTouchListFrom(fingerDetection);
    drawTouch(fingerTouchs);

    // MOUSE
    SkatoloLink.addMouseTo(fingerTouchs, skatolo, this);
    SkatoloLink.updateTouch(fingerTouchs, skatolo);
    skatolo.draw(getGraphics());
  }

  void drawTouch(TouchList fingerTouchs) {
    fill(255, 0, 20);
    for (Touch t : fingerTouchs) {
      PVector p = t.position;
      ellipse(p.x, p.y, 10, 10);
    }
  }
}
