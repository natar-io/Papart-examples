import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.depthcam.analysis.*;

import org.bytedeco.javacv.*;
import org.bytedeco.javacpp.opencv_core.*;
import org.bytedeco.javacpp.freenect;
import toxi.geom.*;
import peasy.*;

PeasyCam cam;

PointCloudForDepthAnalysis pointCloud;

DepthAnalysisPImageView kinectAnalysis;
DepthCameraDevice depthCameraDevice;

int skip = 2;

void settings() {
  size(640, 480, P3D);
}

void setup() {

  Papart papart = new Papart(this);

  try{
  // load the depth camera
  depthCameraDevice = papart.loadDefaultDepthCamera();

  kinectAnalysis = new DepthAnalysisPImageView(this, depthCameraDevice);
  depthCameraDevice.getMainCamera().start();
  } catch(CannotCreateCameraException e){
      println("Cannot init/start the camera");
      exit();
  }
  // The intrinsic calibration is valid after the start() for some devices. 
  kinectAnalysis.updateCalibrations(depthCameraDevice);
}


void draw() {
  background(100);
  // retreive the camera image.
  try {
    depthCameraDevice.getMainCamera().grab();
  } 
  catch(Exception e) {
    println("Could not grab the image " + e);
  }
  try{
  IplImage colourImg = depthCameraDevice.getColorCamera().getIplImage();
  IplImage depthImg = depthCameraDevice.getDepthCamera().getIplImage();

  if (colourImg == null || depthImg == null)
    return;

  PImage alignedImage = kinectAnalysis.update(depthImg, colourImg, skip);

  image(alignedImage, 0, 0, width, height);
  } catch(Exception e){
      e.printStackTrace();
  }
}

void close() {
  try {
    depthCameraDevice.close();
  }
  catch(Exception e) {
  }
}
