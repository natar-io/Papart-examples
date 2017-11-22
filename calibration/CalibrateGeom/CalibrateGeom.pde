import fr.inria.papart.procam.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.tracking.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacv.RealSenseFrameGrabber;
import org.bytedeco.javacv.ProjectiveDevice;
import processing.video.*;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.*;
import tech.lity.rea.skatolo.gui.group.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import tech.lity.rea.svgextended.PShapeSVGExtended;

import static org.bytedeco.javacpp.opencv_core.IPL_DEPTH_8U;
import static org.bytedeco.javacpp.opencv_imgproc.CV_BGR2GRAY;
import static org.bytedeco.javacpp.opencv_imgproc.cvCvtColor;
import org.bytedeco.javacpp.ARToolKitPlus;

public void settings(){
    size(640, 480, OPENGL);
}

CameraConfiguration cameraConfig;
Camera camera;
IplImage currentImage = null;
ARToolKitPlus.MultiTracker tracker;
IplImage grayImage;
DetectedMarker[] markersDetected;
MarkerList markersModel;
GeometricCalibratorP calibrator;

public void setup(){
    initCamera();
    initTracking();
    loadMarkerList();
    initCalibrator();
    initGUI();
}

public void draw(){
    background(0);
    camera.grab();
    currentImage = camera.getIplImage();
    image(camera.getPImage(),0, 0, width, height);

    drawMarkerDetection();
}


private void initCamera(){
    try{
	cameraConfig = new CameraConfiguration();

	// Load from file
	cameraConfig.loadFrom("camera-config.xml");

	// // Or manually 
	// cameraConfig.setCameraName("/dev/video0");
	// cameraConfig.setCameraType(Camera.Type.FFMPEG);

	// // Options for depth and special cameras.
	// cameraConfig.setCameraFormat("");

	camera = cameraConfig.createCamera();

	// Same as this:
	// CameraFactory.createCamera(Camera.Type.FFMPEG, "/dev/video0", "");
	
    	camera.setParent(this);
    	camera.setSize(640, 480);
	camera.start();
    }catch(CannotCreateCameraException cce){
	println("Cannot start the camera..");
	exit();
    }
}


private void initTracking(){
    tracker = DetectedMarker.createDetector(camera.width(),
					    camera.height());
    grayImage = IplImage.create(camera.width(),
				camera.height(),
				IPL_DEPTH_8U,
				1);
}

void loadMarkerList(){
    XML xml = loadXML("A4-calib.svg");
    //     XML xml = loadXML(sketchPath()+"/calibration-point.svg");
    markersModel = MarkerSvg.getMarkersFromSVG(xml);
}


void initCalibrator(){

    try{
	calibrator =
	GeometricCalibratorP.
	createGeometricCalibrator(camera.width(),
				  camera.height(),
				  "camera0");
    }catch(Exception e){
	println("exception " + e);
	e.printStackTrace();
    }
}


void findMarkers(IplImage img){
    cvCvtColor(img, grayImage, CV_BGR2GRAY);

    // PROBLEM HERE:
    // It detects "fantom markers", markers that were
    // there in the previous frame for some reasons...
    markersDetected = DetectedMarker.detect(tracker, grayImage);
}


public void keyPressed(){
    if(key == 'd'){
	tryAddMarkers();
    }
    
    if(key == 'c'){
	tryCalibrate();
    }
    
    if(key == 'r'){
	calibrator.clearMarkers();
    }
}

void tryAddMarkers(){
    if(currentImage != null){
	findMarkers(currentImage);
	println("Markers found: " + markersDetected.length);
	
	if(markersDetected.length > 2){
	    println("Add markers");
	    calibrator.addMarkers(markersModel, markersDetected);
	}
    }else{
	println("No Image yet");
    }
}


void tryCalibrate(){
    if(markersDetected == null || markersDetected.length == 0){
	println("Cannot calibrate with no markers");
	return;
    }

    try{
    println("Calibrate");
    calibrator.calibrate(false);

    println("Extract calibration");
    ProjectiveDevice d = calibrator.getProjectiveDevice();

    ProjectiveDeviceP pdp;
    pdp = ProjectiveDeviceP.createSimpleDevice(1, 1,
					       0.5f, 0.5f,
					       camera.width(),
					       camera.height());

    ProjectiveDeviceP.loadParameters(d, pdp);
    println("Calibration");
    println(pdp);

    // Save...
    pdp.saveTo(this, "camera.yaml");
    pdp.saveTo(this, "camera.xml");
    cameraConfig.saveTo(this, "cameraConfiguration.xml");

    }catch(Exception e){
	e.printStackTrace();
    }
}

Skatolo skatolo;
private void initGUI(){
    skatolo = new Skatolo(this);
}

