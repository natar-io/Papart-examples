import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.depthcam.analysis.*;

import tech.lity.rea.pointcloud.*;
import org.bytedeco.javacv.*;
import org.bytedeco.opencv.opencv_core.*;
// import org.bytedeco.javacpp.freenect;
// import org.bytedeco.javacv.RealSenseFrameGrabber;
// import org.openni.*;
import toxi.geom.*;
import peasy.*;


PeasyCam cam;
PointCloudForDepthAnalysis pointCloud;
// DepthAnalysisPImageView depthAnalysis;
DepthAnalysisPImageView depthAnalysis;
DepthCameraDevice depthCameraDevice;

CameraRealSense camRS = null;

// Quality of depth is divided by skip in X and Y axes. 
// Warning non-even skip value can cause a crashes.
int skip = 16;

void settings() {
    size(640, 480, P3D);
}


PImage colorImage; 
Camera mainCamera;

void setup() {

  Papart papart = new Papart(this);
  // load the depth camera
  try{

      papart.initCamera();
      mainCamera = papart.getCameraTracking();
      //  mainCamera.start();

      depthCameraDevice = papart.loadDefaultDepthCamera();
      // papart.startCameraThread();

      // WARNING: Starts both cameras. 
      depthCameraDevice.getMainCamera().start();
      //depthCameraDevice.getMainCamera().start();
      // depthCameraDevice.getMainCamera().setThread();
      
      // load the stereo extrinsics.
      depthCameraDevice.loadDataFromDevice();
  }catch (Exception e){
      println("Cannot start the DepthCamera: " + e );
      e.printStackTrace();
  }
  // depthAnalysis = new DepthAnalysisPImageView(this, depthCameraDevice);
  depthAnalysis = new DepthAnalysisPImageView(this, depthCameraDevice);
  pointCloud = new PointCloudForDepthAnalysis(this, (DepthAnalysisImpl) depthAnalysis, skip);

  //  Set the virtual camera
  cam = new PeasyCam(this, 0, 0, -800, 800);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1200);
  cam.setActive(true);

  colorImage = createImage(640, 480, RGB);
}

boolean first = true;

void draw() {
  background(100);


  // WARNING: grabs both cameras. 
  // retreive the camera image.
  depthCameraDevice.getMainCamera().grab();
  // mainCamera.grab();

  IplImage colorImg = mainCamera.getIplImage(); //  depthCameraDevice.getColorCamera().getIplImage();
  IplImage depthImg = depthCameraDevice.getDepthCamera().getIplImage();
  
  println("Camera Color image: " + colorImg);
  if (depthImg == null) { 
    println("No depth Image");
    return;
  }  // || colorImg == null){
  //     println("No depth Image");
  //     return;
  // }
  //if(first){
  //    depthAnalysis.initWithCalibrations(depthCameraDevice);
  //    first = !first;
  // }
  //      if(!depthAnalysis.isReady()){
  //      }
//  update(IplImage depth, IplImage color, int skip) 

  println("D: " + depthAnalysis);

  depthAnalysis.update(depthImg, colorImg, skip); // colorImage, skip);
  
  pointCloud.updateWith(depthAnalysis);
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
