// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.opencv_core;
import toxi.geom.*;
import org.openni.*;

import processing.video.*;


Papart papart;
Camera camera;

void settings() {
  size(640, 480, P3D);
}

void setup() {
  // Creating a camera using the PapARt object
  papart = new Papart(this);
  try {
    papart.initCamera("0", Camera.Type.OPENNI2, "depth");
  }
  catch (CannotCreateCameraException ccce) {
    println(ccce.toString());
  }
  papart.startCameraThread();
  camera = papart.getCameraTracking();
}

void draw() {
  // draw the camera image
  if (camera != null) {
    PImage img = camera.getPImage();
    if (img != null) {
      image(img, 0, 0, img.width, img.height);
    }
  }
}
