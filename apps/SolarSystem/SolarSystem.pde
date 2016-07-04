// PapARt library
import fr.inria.papart.procam.*;
import org.bytedeco.javacpp.opencv_core;
import org.reflections.*;
import toxi.geom.*;

Papart papart;
float planetScale = 2f / 20000f;
PVector boardSize = new PVector(297, 210);   //  21 * 29.7 cm
PShader texlightShader;

void settings() {
    size(200, 200, P3D);
}

public void setup() {
  papart = Papart.seeThrough(this); // application using only a camera, screen rendering

  texlightShader = loadShader("shaders/texlightfrag.glsl",
                              "shaders/texlightvert.glsl");

  papart.loadSketches();  // loads earth, moon, sun sketches
  papart.startTracking();
}

void draw() {
}
