import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.depthcam.analysis.*;
import fr.inria.papart.tracking.*;

import tech.lity.rea.pointcloud.*;
import tech.lity.rea.svgextended.PShapeSVGExtended;

import org.bytedeco.javacv.*;
import org.bytedeco.javacpp.opencv_core.*;
import org.bytedeco.javacpp.freenect;
import org.bytedeco.javacv.RealSenseFrameGrabber;
import toxi.geom.*;
import org.openni.*;
import peasy.*;
import fr.inria.papart.calibration.files.HomographyCalibration;
import redis.clients.jedis.*;


PeasyCam cam;
PointCloudForDepthAnalysis pointCloud;
DepthAnalysisPImageView depthAnalysis;
DepthCameraDevice depthCameraDevice;
Camera cameraTracking;
MarkerBoard markerboard;

PMatrix3D extrinsics;

ProjectiveDeviceP rgbDevice, irDevice;

PApplet parent;
// gui elements
float irFx, irFy, irCx, irCy;
float rgbFx, rgbFy, rgbCx, rgbCy;

CameraRealSense camRS = null;

// Quality of depth is divided by skip in X and Y axes. 
// Warning non-even skip value can cause a crashes.
int skip = 1;

void settings() {
    size(640*2, 480*2, P3D);
}


void setup() {

    Papart papart = new Papart(this);


    // load the depth camera
    try{

	papart.initCamera();
	depthCameraDevice = papart.loadDefaultDepthCamera();
	// depthCameraDevice.getMainCamera().start();

	// load the stereo extrinsics.
	//	depthCameraDevice.loadDataFromDevice();
    } catch (CannotCreateCameraException ex) {
	throw new RuntimeException("Cannot start the default camera: " + ex);
    }catch (Exception e){
	println("Cannot start the DepthCamera: " + e );
	e.printStackTrace();
    }

    
    papart.startTracking();
    //    cameraTracking = papart.getCameraTracking();
    cameraTracking = depthCameraDevice.getColorCamera();

    rgbDevice =  depthCameraDevice.getColorCamera().getProjectiveDevice();
    irDevice =  depthCameraDevice.getDepthCamera().getProjectiveDevice();
    extrinsics = depthCameraDevice.getStereoCalibrationInv();
    
    
    depthAnalysis = new DepthAnalysisPImageView(this, depthCameraDevice);
    pointCloud = new PointCloudForDepthAnalysis(this, depthAnalysis, skip);

    // create a markerboard
    markerboard = MarkerBoardFactory.create(Papart.markerFolder + "calib1.svg");
    println("Board " + markerboard);
    // track it with the color camera.
    cameraTracking.track(markerboard);

    parent  = this;

    initGui();
    
    //  Set the virtual camera
    cam = new PeasyCam(this, 0, 0, -800, 800);
    cam.setMinimumDistance(0);
    cam.setMaximumDistance(1200);
    cam.setActive(true);
}

int frameID = 0;

void initFocals(){
    irFx = irDevice.getFx();
    println("irfx 1 " + irFx);
    
    irFy = irDevice.getFy();
    irCx = irDevice.getCx();
    irCy = irDevice.getCy();
    rgbFx = rgbDevice.getFx();
    rgbFy = rgbDevice.getFy();
    rgbCx = rgbDevice.getCx();
    rgbCy = rgbDevice.getCy();
}

boolean locked = true;
boolean print = false;

void keyPressed(){
    locked = false;
    if(key == 'p'){
	print = !print;
    }
}


void draw() {
  background(100);
  
  // Get the intrinsics
  if(!locked){
      updateIntrinsics();
      
  }
      fill(180, 180);  
      //  drawModel();
  drawTrackedSheet();
  drawPointCloud();
      
}

void drawModel()
{
      pushMatrix();

      translate(0, 0, -600);
      rect(0, 0, 297, 210);
      popMatrix();
}

float rx, ry, rz;
float tx, ty, tz;

void drawTrackedSheet()
{
      pushMatrix();
      PMatrix3D  p = markerboard.getPosition(cameraTracking);
      g.scale(1, 1, -1);

      // extrinsics...

      PMatrix3D extr = new PMatrix3D(1, 0, 0, 0,
				     0, 1, 0, 0,
				     0, 0, 1, 0,
				     0, 0, 0, 1);

      extr.rotateX(rx);
      extr.rotateY(ry);
      extr.rotateZ(rz);
      //      extr.translate(extrinsics.m03, extrinsics.m13, extrinsics.m23);
      extr.translate(tx, ty, tz);

      PMatrix3D inv = extr.get();
      inv.invert();
      
      depthCameraDevice.setStereoCalibration(extr);

      //      extr.invert();
      
      if(print) {
	  extr.print();
	  println("Warning: This sketch saves only the extrinsics, not the intrinsics !");
	  HomographyCalibration.saveMatTo(this, extr, sketchPath() + "/extr.xml");
      }
      g.applyMatrix(extr);
      //      g.applyMatrix(extrinsics);
      g.applyMatrix(p);
 
      
      rect(0, 0, 297, 210);
      popMatrix();
}


void drawPointCloud()
{
   
      depthAnalysis.update(depthCameraDevice, skip);
      pointCloud.update();
      //      pointCloud.updateWith(depthAnalysis);
      pointCloud.drawSelf((PGraphicsOpenGL) g);
}


void updateIntrinsics()
{
  PMatrix3D intrinsicsIR = irDevice.getIntrinsics();

  // Modify it
  intrinsicsIR.m00 = irFx;
  intrinsicsIR.m11 = irFy;
  intrinsicsIR.m02 = irCx;
  intrinsicsIR.m12 = irCy;

  // Update the device
  irDevice.updateFromIntrinsics();

  PMatrix3D intrinsicsRGB = rgbDevice.getIntrinsics();

  // Modify it
  intrinsicsRGB.m00 = rgbFx;
  intrinsicsRGB.m11 = rgbFy;
  intrinsicsRGB.m02 = rgbCx;
  intrinsicsRGB.m12 = rgbCy;

  // Update the device
  rgbDevice.updateFromIntrinsics();

}

public void dispose(){
    cf.dispose();
    try{
	// 1 sec to die.
	Thread.sleep(1000);
    }
    catch(Exception e){
    }
    super.dispose();
}
