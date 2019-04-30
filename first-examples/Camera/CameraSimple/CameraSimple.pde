// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.opencv_core;
import toxi.geom.*;
import org.openni.*;

Camera camera;

void settings() {
  size(640, 480, P3D);
}

void setup() {
  try {
    camera = CameraFactory.createCamera(Camera.Type.OPENCV, "0");
    camera.setSize(640, 480);
    camera.setParent(this);
    camera.start();
  }
  catch(CannotCreateCameraException cce){
    println("Cannot load the camera: " + cce);
  }
}

void draw() {
  if (camera != null) {
    camera.grab();
    PImage im = camera.getPImage();
    if (im != null) {
      image(im, 0, 0, width, height);
    }
  }
}
