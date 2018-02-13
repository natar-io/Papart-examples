// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.opencv_core;
import org.reflections.*;
import toxi.geom.*;
import processing.video.*;


Papart papart;

Camera camera2;


public void setup() {
  // application only using a camera
  // screen rendering
  papart = Papart.seeThrough(this);
  papart.loadSketches();
  papart.startTracking();

  camera2 = CameraFactory.createCamera(Camera.Type.FFMPEG, ":0.0+1280,0", "x11grab");

  camera2.setSize(800, 400);
  camera2.setParent(this);
  camera2.start();

}

void settings() {
  // the application will be rendered in full screen, and using a 3Dengine.
    size(640, 480, P3D);
}

void draw() {
}
