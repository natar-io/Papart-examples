import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.opencv_core;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

Papart papart;
ARDisplay display;
Camera camera;

void settings() {
    size(640, 480, P3D);
}

MyApp myApp;

void setup() {
  // application only using a camera
  // screen rendering
  papart = Papart.seeThrough(this);
  myApp = new MyApp();
  papart.startTracking();
}

void draw() {
}
