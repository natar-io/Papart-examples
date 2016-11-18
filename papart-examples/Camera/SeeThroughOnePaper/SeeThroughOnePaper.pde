// PapARt library
import fr.inria.papart.procam.*;
import org.bytedeco.javacpp.opencv_core;
import org.reflections.*;
import toxi.geom.*;
import processing.video.*;

Papart papart;

public void setup() {
  // application only using a camera
  // screen rendering
  papart = Papart.seeThrough(this);
  papart.loadSketches();
  papart.startTracking();
}

void settings() {
  // the application will be rendered in full screen, and using a 3Dengine.
  fullScreen(P3D);
}

void draw() {
}
