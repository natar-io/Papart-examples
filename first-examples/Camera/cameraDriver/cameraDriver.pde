// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.opencv_core;  
import toxi.geom.*;
import org.openni.*;
import processing.video.*;

Papart papart;
ARDisplay display;
Camera camera;

void settings() {
  size(640, 480, P3D);
}


void setup() {
  // application only using a camera
  // screen rendering
  papart = new Papart(this);

  // initDefaultCamera();
  // or 
  initSpecificCamera();
  papart.startCameraThread();
  camera = papart.getCameraTracking();
}


void draw() {

  // draw the camera image
  if (camera != null && camera.getPImage() != null) {
    image(camera.getPImage(), 0, 0, width, height);
  }

  // You must get a copy of it to maniplate pixels via loadpixels (with OpenCV and FFMPEG)
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
    papart.initCamera("0", Camera.Type.OPENCV, "rgb", "");
  }
  catch(CannotCreateCameraException cce) {
    println("Cannot start the camera: " + cce);
  }
}
