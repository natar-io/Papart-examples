import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.depthcam.analysis.*;

import fr.inria.papart.calibration.*;

import toxi.geom.*;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.freenect;
import org.bytedeco.javacv.RealSenseFrameGrabber;
import org.bytedeco.javacpp.opencv_core.*;
import java.nio.IntBuffer;

import fr.inria.skatolo.*;
import fr.inria.skatolo.events.*;
import fr.inria.skatolo.gui.controllers.*;
import fr.inria.skatolo.gui.group.*;

import peasy.*;

Skatolo skatolo;
PeasyCam cam;


KinectProcessing kinectAnalysis;
KinectPointCloud pointCloud;

DepthCameraDevice depthCameraDevice;
Camera cameraRGB, cameraDepth;

HomographyCreator homographyCreator;
HomographyCalibration homographyCalibration;
PlaneCalibration planeCalibration;
PlaneAndProjectionCalibration planeProjCalibration;

int precision = 3;
boolean is3D = false;

void settings(){
    size(1200, 900, P3D);
}

void setup(){


    Papart papart = new Papart(this);

    depthCameraDevice = papart.loadDefaultDepthCamera();
    // activate color, activated by default for now. 
    //    depthCameraDevice.getMainCamera().setUseColor(true);
    depthCameraDevice.getMainCamera().start();
    
    cameraRGB = depthCameraDevice.getColorCamera();
    cameraDepth = depthCameraDevice.getDepthCamera();

    try{
	planeProjCalibration = new  PlaneAndProjectionCalibration();
	planeProjCalibration.loadFrom(this, Papart.planeAndProjectionCalib);
	planeCalibration = planeProjCalibration.getPlaneCalibration();
    }catch(NullPointerException e){
	die("Impossible to load the plane calibration...");
    }

    kinectAnalysis = new KinectProcessing(this, depthCameraDevice);
    pointCloud = new KinectPointCloud(this, kinectAnalysis, 1);


  // Set the virtual camera
  cam = new PeasyCam(this, 0, 0, -800, 800);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(5000);
  cam.setActive(true);

  touchDetection = new TouchDetectionSimple2D(kinectAnalysis.getDepthSize());

  touchCalibration = new PlanarTouchCalibration();
  touchCalibration.loadFrom(this, Papart.touchCalib);
  touchDetection.setCalibration(touchCalibration);

  touchDetection3D = new TouchDetectionSimple3D(kinectAnalysis.getDepthSize());
  touchCalibration3D = new PlanarTouchCalibration();
  touchCalibration3D.loadFrom(this, Papart.touchCalib3D);
  touchDetection3D.setCalibration(touchCalibration3D);

  initGui();

  loadCalibration(touchCalibration);

  frameRate(200);

}


// Inteface values
float maxDistance, minHeight;
float planeHeight;
int searchDepth, recursion, minCompoSize, forgetTime;
float trackingMaxDistance;

TouchDetectionSimple2D touchDetection;
TouchDetectionSimple3D touchDetection3D;
PlanarTouchCalibration touchCalibration, touchCalibration3D;


Vec3D[] depthPoints;
IplImage kinectImg;
IplImage kinectImgDepth;
ArrayList<TouchPoint> globalTouchList = new ArrayList<TouchPoint>();
boolean mouseControl;

void grabImages(){
    try {
	depthCameraDevice.getMainCamera().grab();
    } catch(Exception e){
        println("Could not grab the image " + e);
    }
    kinectImg = cameraRGB.getIplImage();
    kinectImgDepth = cameraDepth.getIplImage();
    if(kinectImg == null || kinectImgDepth == null){
    	return;
    }
}

void draw(){

    grabImages();
    cam.setMouseControlled(mouseControl);

    updateCalibration(is3D ? touchCalibration3D : touchCalibration);

    kinectAnalysis.updateMT(kinectImgDepth, kinectImg,
                            planeProjCalibration,
                            precision);

    background(0);
    draw3DPointCloud();

    cam.beginHUD();
    skatolo.draw();
    cam.endHUD();
}

void updateCalibration(PlanarTouchCalibration calib){

    planeCalibration.setHeight(planeHeight);

    calib.setMaximumDistance(maxDistance);
    calib.setMinimumHeight(minHeight);

    calib.setMinimumComponentSize((int)minCompoSize);
    calib.setMaximumRecursion((int) recursion);
    calib.setSearchDepth((int) searchDepth);

    calib.setTrackingForgetTime((int)forgetTime);
    calib.setTrackingMaxDistance(trackingMaxDistance);

    calib.setPrecision(precision);
}

void loadCalibration(PlanarTouchCalibration calib){

    planeHeightSlider.setValue(planeCalibration.getHeight());

    recursionSlider.setValue(calib.getMaximumRecursion());
    searchDepthSlider.setValue(calib.getSearchDepth());
    maxDistanceSlider.setValue(calib.getMaximumDistance());
    minCompoSizeSlider.setValue(calib.getMinimumComponentSize());
    minHeightSlider.setValue(calib.getMinimumHeight());
    forgetTimeSlider.setValue(calib.getTrackingForgetTime());
    trackingMaxDistanceSlider.setValue(calib.getTrackingMaxDistance());
    precisionSlider.setValue(calib.getPrecision());
}



void draw3DPointCloud(){
    KinectDepthData depthData = kinectAnalysis.getDepthData();
    ArrayList<TouchPoint> touchs;

    if(is3D){
	touchs = touchDetection3D.compute(depthData);
    } else{
	touchs = touchDetection.compute(depthData);
    }

    TouchPointTracker.trackPoints(globalTouchList, touchs, millis());

    //     pointCloud.updateWith(kinectAnalysis);
    pointCloud.updateWithFakeColors(kinectAnalysis, touchs);
    pointCloud.drawSelf((PGraphicsOpenGL) g);

    lights();
    stroke(200);
    fill(200);

    colorMode(HSB, 20, 100, 100);
    for(TouchPoint touchPoint : globalTouchList){
    	Vec3D position = touchPoint.getPositionKinect();
    	pushMatrix();
    	translate(position.x, position.y, -position.z);
    	fill(touchPoint.getID() % 20, 100, 100);
	ellipse(0, 0, 3, 3);
    	popMatrix();
    }

}

void switch3D(){
    globalTouchList.clear();
    is3D = !is3D;
    loadCalibration(is3D? touchCalibration3D : touchCalibration);
    switchTo3DButton.setLabel("Switch to " + (is3D? "2D" : "3D"));
}

boolean undist = true;

void keyPressed() {
    if(key == 'i'){
        planeCalibration.flipNormal();
    }
    
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


void saveButton(){
    if(is3D)
        save3D();
    else
        save();
}

void save3D(){
    touchCalibration3D.saveTo(this, Papart.touchCalib3D);
    planeProjCalibration.saveTo(this, Papart.planeAndProjectionCalib);
}

void save(){
    touchCalibration.saveTo(this, Papart.touchCalib);
    planeProjCalibration.saveTo(this, Papart.planeAndProjectionCalib);
}
