import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fr.inria.papart.procam.*; 
import fr.inria.papart.procam.camera.*; 
import fr.inria.papart.depthcam.*; 
import fr.inria.papart.depthcam.devices.*; 
import fr.inria.papart.depthcam.analysis.*; 
import tech.lity.rea.pointcloud.*; 
import org.bytedeco.javacv.*; 
import org.bytedeco.opencv.opencv_core.*; 
import org.openni.*; 
import toxi.geom.*; 
import peasy.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DepthVisualization extends PApplet {










// import org.bytedeco.javacpp.freenect;
// import org.bytedeco.javacv.RealSenseFrameGrabber;




PeasyCam cam;
PointCloudForDepthAnalysis pointCloud;
DepthAnalysisPImageView depthAnalysis;
DepthCameraDevice depthCameraDevice;

CameraRealSense camRS = null;

// Quality of depth is divided by skip in X and Y axes. 
// Warning non-even skip value can cause a crashes.
int skip = 1;

public void settings() {
    size(640 * 4, 480 * 4, P3D);
}

public void setup() {

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
  depthAnalysis = new DepthAnalysisPImageView(this, depthCameraDevice);
  pointCloud = new PointCloudForDepthAnalysis(this, depthAnalysis, skip);

  //  Set the virtual camera
  cam = new PeasyCam(this, 0, 0, -800, 800);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1200);
  cam.setActive(true);
}

boolean first = true;

public void draw() {
  background(100);

  // retreive the camera image.
  depthCameraDevice.getMainCamera().grab();

  IplImage colorImg = depthCameraDevice.getColorCamera().getIplImage();
  IplImage depthImg = depthCameraDevice.getDepthCamera().getIplImage();
  


  if (depthImg == null || colorImg == null){
      println("No depth Image");
      return;
  }
  if(first){
      depthAnalysis.initWithCalibrations(depthCameraDevice);
      first = !first;
  }
  //      if(!depthAnalysis.isReady()){
  //      }
  depthAnalysis.update(depthImg, colorImg, skip);
  
  pointCloud.updateWith(depthAnalysis);
  pointCloud.drawSelf((PGraphicsOpenGL) g);
}



public void keyPressed(){
    if(depthCameraDevice.type() == Camera.Type.REALSENSE){
	setRealSenseMode();
    }
}

public void setRealSenseMode(){
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

public void close() {
    try {
	depthCameraDevice.close();
    }
    catch(Exception e) {
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DepthVisualization" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}