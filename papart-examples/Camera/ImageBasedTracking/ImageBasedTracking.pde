// PapARt library
import fr.inria.papart.procam.*;
import org.bytedeco.javacpp.opencv_core;
import org.reflections.*;
import toxi.geom.*;

Papart papart;

void settings() {
    size(200, 200, P3D);
}

public void setup() {
  // application only using a camera
  // screen rendering
  papart = Papart.seeThrough(this);
  papart.loadSketches();
  papart.startTracking();
}

void draw() {
}
