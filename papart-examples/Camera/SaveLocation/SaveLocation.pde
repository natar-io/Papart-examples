// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import processing.video.*;
import processing.app.Base;

Papart papart;

void settings() {
  size(640, 480, P3D);
}

public void setup() {
  papart = Papart.seeThrough(this);
  papart.loadSketches();
  papart.startTracking();
}

void draw() {
}

void keyPressed() {

  if (key == 's') {
    app.saveLocationTo("../SavedLocations/loc.xml");
    println("Position saved");
    app.getLocation().print();
  }

  if (key == 'l') {
    app.loadLocationFrom("../SavedLocations/loc.xml");
    println("Loaded position from xml");
    app.getLocation().print();
  }

  // Move again
  if (key == 'm') {
    app.useManualLocation(false);
    println("Moved");
  }
}