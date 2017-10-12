import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;

import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

import fr.inria.papart.depthcam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.depthcam.analysis.*;

import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;

import toxi.geom.*;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.freenect;
import org.bytedeco.javacv.RealSenseFrameGrabber;
import org.bytedeco.javacpp.opencv_core.*;
import java.nio.IntBuffer;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;
import tech.lity.rea.skatolo.gui.group.*;


Skatolo skatolo;

DepthAnalysisImpl kinectAnalysis;
PointCloudForDepthAnalysis pointCloud;
ColorTouchInput touchInput;

DepthCameraDevice depthCameraDevice;
Camera cameraIR, cameraDepth;

HomographyCreator homographyCreator;
HomographyCalibration homographyCalibration;
PlaneAndProjectionCalibration planeProjCalibration;

int precision = 3;
boolean is3D = false;

void settings(){
    size(1280, 720, P3D);
}

void setup(){
    Papart papart = new Papart(this);

    try{
	// Load the main camera first, or else the depth camera
	// will default to color. (to fix).
	papart.initCamera();
	depthCameraDevice = papart.loadDefaultDepthCamera();
    } catch(CannotCreateCameraException ccce){
	exit();
    }
    // activate color, activated by default for now. 
    //    depthCameraDevice.getMainCamera().setUseColor(true);
    depthCameraDevice.getMainCamera().start();
    
    cameraIR = depthCameraDevice.getIRCamera();
    cameraDepth = depthCameraDevice.getDepthCamera();

    touchInput = new ColorTouchInput(this, cameraIR);
    touchInput.calib = true;
    // depthCameraDevice.setTouch(touchInput);

    initGui();
    loadCalibrationToGui(touchInput.getCalibration());

  //  frameRate(200);
}


// Inteface values
float maxDistance, maxDistanceInit, minHeight;
float planeHeight;
int searchDepth, recursion, minCompoSize, forgetTime;
float trackingMaxDistance;
float normalFilter;

int currentCalib = 0;
TouchDetectionColor touchDetections[]; 

Vec3D[] depthPoints;
IplImage kinectImg;
IplImage kinectImgDepth;
ArrayList<TrackedDepthPoint> globalTouchList = new ArrayList<TrackedDepthPoint>();
boolean mouseControl;


void draw(){
    //    println("Framerate " + frameRate);
    grabImages();
    updateCalibration();
        
    background(0);


    PImage img = touchInput.getCurrentImage();
    
    if(img != null){
    	fill(255);
    	noStroke();
    	rect(299, 299, 202, 202);
    	image(img, 300, 300, 200, 200);
    	noStroke();
    	// for(PVector v : touchInput.contourList){
    	//     fill(v.z, 100, 100);
    	//     ellipse(v.x * 2 + 300,
    	// 	    v.y * 2 + 300,
    	// 	    1, 1);
    	// }
    }else {
	println("No image");

    }

    colorMode(RGB, 255);
    skatolo.draw();

    ArrayList<TrackedElement> points;

    points = touchInput.getTrackedElements();

    //    colorMode(RGB, 255);
    colorMode(HSB, 20, 100, 100);
    for(TrackedElement pt : points){
	PVector position = pt.getPosition();
    	pushMatrix();
    	translate(position.x, position.y, -position.z);
	println("Pos : " + position);
	PVector p = ((PVector) pt.attachedObject);
	if(p != null) {println("Pos2: " + ((PVector) pt.attachedObject).toString());}
	    
    	fill(pt.getID() % 20, 100, 100);
	ellipse(0, 0, 4,4);
    	popMatrix();
    }
}

void grabImages(){
    // Grab gets the images for all the sub cameras (RGB + DEPTH)
    // The touchInput gets updated with the call to grab()
    try {
	depthCameraDevice.getMainCamera().grab();
	touchInput.update();
	
    } catch(Exception e){
        println("Could not grab the image " + e);
	e.printStackTrace();
    }
    kinectImg = cameraIR.getIplImage();
}


void updateCalibration(){

    PlanarTouchCalibration calib = touchInput.getCalibration();
    calib.setMaximumDistance(maxDistance);
    calib.setMaximumDistanceInit(maxDistanceInit);
    calib.setMinimumHeight(minHeight);

    calib.setNormalFilter((float) normalFilter);
    calib.setMinimumComponentSize((int)minCompoSize);
    calib.setMaximumRecursion((int) recursion);
    calib.setSearchDepth((int) searchDepth);

    calib.setTrackingForgetTime((int)forgetTime);
    calib.setTrackingMaxDistance(trackingMaxDistance);

    calib.setPrecision(precision);

    // Tests
    calib.setTest1(test1);
    calib.setTest2(test2);
    calib.setTest3(test3);
    calib.setTest4(test4);
    calib.setTest5(test5);
}

void loadCalibrationToGui(PlanarTouchCalibration calib){


    recursionSlider.setValue(calib.getMaximumRecursion());
    normalSlider.setValue(calib.getNormalFilter());
    searchDepthSlider.setValue(calib.getSearchDepth());
    maxDistanceSlider.setValue(calib.getMaximumDistance());
    maxDistanceInitSlider.setValue(calib.getMaximumDistanceInit());
    minCompoSizeSlider.setValue(calib.getMinimumComponentSize());
    minHeightSlider.setValue(calib.getMinimumHeight());
    forgetTimeSlider.setValue(calib.getTrackingForgetTime());
    trackingMaxDistanceSlider.setValue(calib.getTrackingMaxDistance());
    precisionSlider.setValue(calib.getPrecision());

    // Testing 
    test1Slider.setValue(calib.getTest1());
    test2Slider.setValue(calib.getTest2());
    test3Slider.setValue(calib.getTest3());
    test4Slider.setValue(calib.getTest4());
    test5Slider.setValue(calib.getTest5());
}



boolean undist = true;

void keyPressed() {

    
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
	rs.setPreset(3);  // USE THIS
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
    save();
}

void save(){

    // Save the calibration(s).
    // for (int i = 0; i < touchDetections.length; i++) {
    // 	String name = Papart.touchCalibrations[i];
    // 	touchDetections[i].getCalibration().saveTo(this, name);
    // }

    touchInput.getCalibration().saveTo(this, Papart.touchColorCalib);
    
    // Save the plane.
    planeProjCalibration.saveTo(this, Papart.planeAndProjectionCalib);
}
