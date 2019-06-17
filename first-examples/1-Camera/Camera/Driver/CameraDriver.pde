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

  initDefaultCamera();
  // initSpecificCamera();

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
  // You must get a copy of it to manipulate pixels via loadpixels (with OpenCV and FFMPEG)
  //PImage copy =  camera.getPImageCopy();
}

void initDefaultCamera() {
  try {
    papart.initCamera();
  }
  catch(CannotCreateCameraException cce) {
    println("Cannot start the camera: " + cce);
  }
}

void initSpecificCamera() {
  try {
    papart.initCamera("0", Camera.Type.OPENCV, "");
  }
  catch(CannotCreateCameraException cce) {
    println("Cannot start the camera: " + cce);
  }
}
