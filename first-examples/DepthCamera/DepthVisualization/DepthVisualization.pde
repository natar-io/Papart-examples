import fr.inria.papart.procam.*;
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


PeasyCam cam;

PointCloudForDepthAnalysis pointCloud;

DepthAnalysisPImageView kinectAnalysis;
DepthCameraDevice depthCameraDevice;


CameraRealSense camRS = null;

// Warning non-even skip value causes a crash.
int skip = 2;

void settings() {
    size(640, 480, P3D);
}

void setup() {

  Papart papart = new Papart(this);
  // load the depth camera
  try{
      depthCameraDevice = papart.loadDefaultDepthCamera();
      depthCameraDevice.getMainCamera().start();

      // load the stereo extrinsics.
      depthCameraDevice.loadDataFromDevice();
  }catch (Exception e){
      println("Cannot start the DepthCamera: " + e );
      e.printStackTrace();
  }

  kinectAnalysis = new DepthAnalysisPImageView(this, depthCameraDevice);
  pointCloud = new PointCloudForDepthAnalysis(this, kinectAnalysis, skip);

  //  Set the virtual camera
  cam = new PeasyCam(this, 0, 0, -800, 800);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1200);
  cam.setActive(true);
}


void draw() {
  background(100);

  // retreive the camera image.
  depthCameraDevice.getMainCamera().grab();

  IplImage colorImg = depthCameraDevice.getColorCamera().getIplImage();
  IplImage depthImg = depthCameraDevice.getDepthCamera().getIplImage();
  
  if (depthImg == null || colorImg == null){
      println("No depth Image");
      return;
  }

  // TODO: color image refresh is very weird: to check. 
  // PImage colImg = depthCameraDevice.getColorCamera().getPImage();
  // image(colImg, 0, 0, width, height);

  try{
  kinectAnalysis.update(depthImg, colorImg, skip);
  }catch(Exception e){

      e.printStackTrace();
  }
  
  pointCloud.updateWith(kinectAnalysis);
  pointCloud.drawSelf((PGraphicsOpenGL) g);
}



void keyPressed(){
    if(depthCameraDevice.type() == Camera.Type.REALSENSE){
	setRealSenseMode();
    }
}

void setRealSenseMode(){
    RealSenseFrameGrabber rs = ((RealSense)depthCameraDevice).getMainCamera().getFrameGrabber();
	
    if(key == '1')
	rs.setPreset(1);
    if(key == '2')
	rs.setPreset(2);
    if(key == '3')
	rs.setPreset(3);
    if(key == '4')
	rs.setPreset(4);
    if(key == '5')
	rs.setPreset(5);
    if(key == '6')
	rs.setPreset(6);
    if(key == '7')
	rs.setPreset(7);
    if(key == '8')
	rs.setPreset(8);
    if(key == '9')
	rs.setPreset(9);
    if(key == '0')
	rs.setPreset(0);
}

void close() {
    try {
	depthCameraDevice.close();
    }
    catch(Exception e) {
    }
}
