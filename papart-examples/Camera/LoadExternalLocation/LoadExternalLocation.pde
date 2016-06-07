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
  size(400, 400, P3D);
}

public void setup() {
  papart = Papart.seeThrough(this);
  papart.loadSketches();
  papart.startTracking();
}

void draw() {
}

void keyPressed() {
  app.loadLocationFrom("../SavedLocations/loc.xml");
  app.getLocation().print();
}