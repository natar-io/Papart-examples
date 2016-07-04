// PapARt library
import fr.inria.papart.procam.*;
import org.bytedeco.javacpp.opencv_core;
import org.reflections.*;
import toxi.geom.*;

Papart papart;
float planetScale = 2f / 20000f;
PVector boardSize = new PVector(297, 210);   //  21 * 29.7 cm

public void setup() {
  papart = Papart.seeThrough(this); // application using only a camera, screen rendering

  papart.loadSketches();  // loads earth, moon, sun sketches
  papart.startTracking();
}

void settings() {
  fullScreen(P3D);
}

void draw() {
}