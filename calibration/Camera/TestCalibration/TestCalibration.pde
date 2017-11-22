import fr.inria.papart.procam.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.display.*;
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

Camera camera;
IplImage currentImage = null;
ARToolKitPlus.MultiTracker tracker;
IplImage grayImage;
DetectedMarker[] markersDetected;
MarkerList markersModel;
PMatrix3D pose = null;

public void setup(){
    initCamera();
    initTracking();
    loadMarkerList();
    initRendering();
    initGUI();
}

public void draw(){
    background(0);
    camera.grab();
    currentImage = camera.getIplImage();
    image(camera.getPImage(),0, 0, width, height);


    if(currentImage!= null){
	findMarkers(currentImage);
	estimatePose();
    }
    
    drawMarkerDetection();
    drawAR();
}


private void initCamera(){
    try{

	CameraConfiguration cameraConfig = new CameraConfiguration();
	cameraConfig.loadFrom(this, "cameraConfiguration.xml");
	camera = cameraConfig.createCamera();

    	camera.setParent(this);
	camera.setCalibration("camera.yaml");
	//	camera.setCalibration("camera.xml");
	//	camera.setSize(640, 480);
	// -> Redundant  with setCalibration.
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

ARDisplay display;

void initRendering(){
    try{
	display = new ARDisplay(this, camera);
	display.init(); // allocate the buffers. 
	display.manualMode(); // rendering done in Draw()
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
	if(currentImage != null){
	findMarkers(currentImage);
	}
    }
    
    if(key == 'p'){
	estimatePose();
    }
}


void estimatePose(){
    if(markersDetected == null || markersDetected.length == 0){
	println("Cannot estimate pose without markers");
	return;
    }

    pose = DetectedMarker.compute3DPos(markersDetected, markersModel, camera);

}

Skatolo skatolo;
private void initGUI(){
    skatolo = new Skatolo(this);
}

