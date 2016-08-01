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

KinectDevice kinectDevice;
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

    kinectDevice = Papart.loadDefaultKinectDevice(this);
     //kinectDevice = KinectDevice.createKinectOne(this);

    cameraRGB = kinectDevice.getCameraRGB();
    cameraDepth = kinectDevice.getCameraDepth();

    try{
	planeProjCalibration = new  PlaneAndProjectionCalibration();
	planeProjCalibration.loadFrom(this, Papart.planeAndProjectionCalib);
	planeCalibration = planeProjCalibration.getPlaneCalibration();
    }catch(NullPointerException e){
	die("Impossible to load the plane calibration...");
    }

    kinectAnalysis = new KinectProcessing(this, kinectDevice);
    pointCloud = new KinectPointCloud(this, kinectAnalysis, 1);


  // Set the virtual camera
  cam = new PeasyCam(this, 0, 0, -800, 800);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(5000);
  cam.setActive(true);

  touchDetection = new TouchDetectionSimple2D(kinectDevice.depthSize());

  touchCalibration = new PlanarTouchCalibration();
  touchCalibration.loadFrom(this, Papart.touchCalib);
  touchDetection.setCalibration(touchCalibration);

  touchDetection3D = new TouchDetectionSimple3D(kinectDevice.depthSize());
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
	cameraRGB.grab();
        cameraDepth.grab();
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



void keyPressed() {

    if(key == 'i'){
        planeCalibration.flipNormal();
    }
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
