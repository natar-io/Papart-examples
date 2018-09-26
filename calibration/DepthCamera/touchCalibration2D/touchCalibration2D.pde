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
import tech.lity.rea.pointcloud.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;
import tech.lity.rea.skatolo.gui.group.*;

import redis.clients.jedis.*;
import org.openni.*;

import peasy.*;

Skatolo skatolo;
PeasyCam cam;


DepthAnalysisImpl kinectAnalysis;
PointCloudForDepthAnalysis pointCloud;
DepthTouchInput touchInput;

DepthCameraDevice depthCameraDevice;
Camera cameraRGB, cameraDepth;

HomographyCreator homographyCreator;
HomographyCalibration homographyCalibration;
PlaneCalibration planeCalibration;
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
    
    cameraRGB = depthCameraDevice.getColorCamera();
    cameraDepth = depthCameraDevice.getDepthCamera();

    try{


        planeProjCalibration = new PlaneAndProjectionCalibration();
//        calibration.loadFrom(this.applet, planeAndProjectionCalib);

        HomographyCalibration hc = new HomographyCalibration();
        hc.loadFrom(this, Papart.homographyCalib);
        
        PlaneCalibration pc = new PlaneCalibration();
        pc.loadFrom(this, Papart.planeCalib);
        planeProjCalibration.setPlane(pc);
        planeProjCalibration.setHomography(hc);

	planeCalibration = pc;

    }catch(NullPointerException e){
	die("Impossible to load the plane calibration...");
    }
 
    kinectAnalysis = new DepthAnalysisImpl(this, depthCameraDevice);
    pointCloud = new PointCloudForDepthAnalysis(this, kinectAnalysis, 1);
 

    touchInput = new DepthTouchInput(this,
				     depthCameraDevice,
				     kinectAnalysis,
				     planeProjCalibration);
    depthCameraDevice.setTouch(touchInput);

    touchInput.initSimpleTouchDetection();
    touch2D = touchInput.getSimpleDetection();
    initGui();
    loadCalibrationToGui(touch2D.getCalibration());

    //  frameRate(200);
}


// Inteface values
float maxDistance, maxDistanceInit, minHeight;
float planeHeight;
int searchDepth, recursion, minCompoSize, forgetTime;
float trackingMaxDistance;
float normalFilter;

int currentCalib = 0;
TouchDetectionDepth touchDetections[]; 
Simple2D touch2D;
Vec3D[] depthPoints;
IplImage kinectImg;
IplImage kinectImgDepth;
ArrayList<TrackedDepthPoint> globalTouchList = new ArrayList<TrackedDepthPoint>();
boolean mouseControl;

void grabImages(){

    // Grab ges tthe images for all the sub cameras (RGB + DEPTH)
    // The touchInput gets updated with the call to grab()
    try {
	depthCameraDevice.getMainCamera().grab();
    } catch(Exception e){
        println("Could not grab the image " + e);
    }
    kinectImg = cameraRGB.getIplImage();
    kinectImgDepth = cameraDepth.getIplImage();
}

void initVirtualCamera(){
    // Set the virtual camera
    cam = new PeasyCam(this, 0, 0, -800, 800);
    cam.setMinimumDistance(100);
    cam.setMaximumDistance(5000);
    cam.setActive(true);
}

void draw(){
    //    println("Framerate " + frameRate);
    grabImages();
    updateCalibration();
        
    background(0);

    if(mouseControl && cam == null){
	initVirtualCamera();
    }
    if(cam != null){
	cam.setMouseControlled(mouseControl);
	cam.beginHUD();
    }

    colorMode(RGB, 255);
    skatolo.draw();
    if(cam != null){
	cam.endHUD();
    }

    ArrayList<TrackedDepthPoint>  points = new ArrayList<TrackedDepthPoint>(touch2D.getTouchPoints());

    //    colorMode(RGB, 255);
    if(depthVisuType == 0){
	pointCloud.updateWithCamColors(kinectAnalysis, points);
    }
    if(depthVisuType == 1){
	pointCloud.updateWithNormalColors(kinectAnalysis, points);
    }
    if(depthVisuType == 2){
	pointCloud.updateWithIDColors(kinectAnalysis, points);
    }
    pointCloud.drawSelf((PGraphicsOpenGL) g);

    colorMode(HSB, 20, 100, 100);
    for(TrackedDepthPoint pt : points){
	Vec3D position = pt.getPositionKinect();
    	pushMatrix();
    	translate(position.x, position.y, -position.z);
    	fill(pt.getID() % 20, 100, 100);
	if(pt.mainFinger){
	    ellipse(0, 0, 18,18);
	}else{
	    ellipse(0, 0, 4,4);
	}
    	popMatrix();
    }

    
    //     draw3DPointCloud();
}

void updateCalibration(){

    PlanarTouchCalibration calib = touch2D.getCalibration();
    planeCalibration.setHeight(planeHeight);

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
}

void loadCalibrationToGui(PlanarTouchCalibration calib){

    planeHeightSlider.setValue(planeCalibration.getHeight());

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

}



boolean undist = true;

void keyPressed() {
    if(key == 'i'){
        planeCalibration.flipNormal();
    }

    if(key == 'c'){
	initVirtualCamera();
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
    // detection
    touch2D.getCalibration().saveTo(this, Papart.touchCalib);
    // plane
    planeProjCalibration.saveTo(this, Papart.planeAndProjectionCalib);
}
