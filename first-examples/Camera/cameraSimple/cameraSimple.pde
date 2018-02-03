// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.opencv_core;
import toxi.geom.*;
import org.openni.*;

Camera camera2;

void settings() {
  size(640, 480, P3D);
}


void setup() {
  try{
  camera2 = CameraFactory.createCamera(Camera.Type.OPENCV, "0");

  camera2.setSize(640, 480);
  camera2.setParent(this);
  camera2.start();
  } catch(CannotCreateCameraException cce){
    println("Cannot load the camera: " + cce);
  }
} 

void draw() {

  camera2.grab();
  PImage im = camera2.getPImage();
  if (im != null) {
    image(im, 0, 0, width, height);
  }
  
}
