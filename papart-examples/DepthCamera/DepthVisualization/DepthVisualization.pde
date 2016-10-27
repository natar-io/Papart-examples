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

KinectPointCloud pointCloud;

KinectProcessing kinectAnalysis;
KinectDevice kinectDevice;

RealSenseFrameGrabber rs = null;
CameraRealSense camRS = null;

int skip = 1;

void settings() {
    size(640, 480, P3D);
}

void setup() {

  Papart papart = new Papart(this);
  // load the depth camera
  try{
  papart.startDefaultKinectCamera();
  }catch (Exception e){
      println("e : " + e );
      e.printStackTrace();
  }
  kinectDevice = papart.getKinectDevice();
  kinectAnalysis = new KinectProcessing(this, kinectDevice);
  pointCloud = new KinectPointCloud(this, kinectAnalysis, skip);

  if(kinectDevice.type() == KinectDevice.Type.REALSENSE){
      camRS = ((RealSense)kinectDevice).getMainCamera();
      rs = camRS.getFrameGrabber();
  }
  
  //  Set the virtual camera
  cam = new PeasyCam(this, 0, 0, -800, 800);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1200);
  cam.setActive(true);
}


void draw() {
  background(100);

  // retreive the camera image.
  try {
      if(camRS != null){
	  // Actual grab for RS, the other just read the data grabbed.
	  camRS.grab();

      } 

      kinectDevice.getCameraRGB().grab();
      kinectDevice.getCameraDepth().grab();
  } 
  catch(Exception e) {
    println("Could not grab the image " + e);
  }

  // DEBUG: make sure that the images arrive.
  // PImage img = kinectDevice.getCameraRGB().getPImage();
  // if(img != null){
  //     println("drawing !");
  //     image(img, 0, 0, width, height);
  // }else{
  //     println("Image null");
  // }

  IplImage colourImg = kinectDevice.getCameraRGB().getIplImage();
  IplImage depthImg = kinectDevice.getCameraDepth().getIplImage();

  if (colourImg == null || depthImg == null){
      println("No Image");
      return;
  }

  try{
      kinectAnalysis.update(depthImg, colourImg, skip);
  } catch(Exception e ) {
      println("exception " + e);
      e.printStackTrace();
  }
  pointCloud.updateWith(kinectAnalysis);
  pointCloud.drawSelf((PGraphicsOpenGL) g);
}


void keyPressed(){

    if(rs == null)
	return;
    
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
    kinectDevice.close();
  }
  catch(Exception e) {
  }
}
