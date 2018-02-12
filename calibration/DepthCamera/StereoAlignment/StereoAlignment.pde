import fr.inria.papart.procam.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.depthcam.analysis.*;

import org.bytedeco.javacv.*;
import org.bytedeco.javacpp.opencv_core.*;
import org.bytedeco.javacpp.freenect;
import org.bytedeco.javacv.RealSenseFrameGrabber;
import toxi.geom.*;
import peasy.*;

import org.openni.*;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;
import tech.lity.rea.skatolo.gui.widgets.*;


PeasyCam cam;

PointCloudForDepthAnalysis pointCloud;

DepthAnalysisPImageView kinectAnalysis;
DepthCameraDevice depthCameraDevice;


CameraRealSense camRS = null;

// Warning non-even skip value causes a crash.
int skip = 2;


boolean toSave = false;
PMatrix3D stereoCalib;

void settings() {
    size(640, 480, P3D);
}

void setup() {

  Papart papart = new Papart(this);
  // load the depth camera
  try{
      depthCameraDevice = papart.loadDefaultDepthCamera();
      // depthCameraDevice.getMainCamera().setUseColor(true);  // enabled by default
      depthCameraDevice.getMainCamera().start();


  kinectAnalysis = new DepthAnalysisPImageView(this, depthCameraDevice);
  pointCloud = new PointCloudForDepthAnalysis(this, kinectAnalysis, skip);
  

  //  Set the virtual camera
  cam = new PeasyCam(this, 0, 0, -800, 800);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1200);
  cam.setActive(true);

  stereoCalib = HomographyCalibration.getMatFrom(this, Papart.AstraSStereoCalib);

    }catch (Exception e){
      println("Cannot start the DepthCamera: " + e );
      e.printStackTrace();
  }

  initGUI();
  
}


boolean once = false;

void draw() {
  background(100);
  
  // retreive the camera image.
  depthCameraDevice.getMainCamera().grab();

  if( !once){
      //    kinectAnalysis.updateCalibrations(depthCameraDevice);
      once = true;
  }

  
  IplImage colorImg = depthCameraDevice.getColorCamera().getIplImage();
  IplImage depthImg = depthCameraDevice.getDepthCamera().getIplImage();
  
  if (depthImg == null || colorImg == null){
      println("No depth Image");
      return;
  }

  // TODO: color image refresh is very weird: to check. 
  // PImage colImg = depthCameraDevice.getColorCamera().getPImage();
  // image(colImg, 0, 0, width, height);

  stereoCalib.m03 = xOffset;
  stereoCalib.m13 = yOffset;
  depthCameraDevice.setStereoCalibration(stereoCalib);
  depthCameraDevice.getDepthCamera().setExtrinsics(depthCameraDevice.getStereoCalibration());

  try
      {      kinectAnalysis.update(depthImg, colorImg, skip);}
  catch (Exception e) {e.printStackTrace();}
  
  pointCloud.updateWith(kinectAnalysis);
  pointCloud.drawSelf((PGraphicsOpenGL) g);

  drawGUI();
  if(toSave){
      save();
  }
}

void save(){
    println("Saving...");
    HomographyCalibration.saveMatTo(this, stereoCalib, Papart.AstraSStereoCalib);
}


void keyPressed(){

}

void close() {
    try {
	depthCameraDevice.close();
    }
    catch(Exception e) {
    }
}
