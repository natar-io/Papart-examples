import fr.inria.papart.multitouch.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.tracking.*;
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.depthcam.analysis.*;
import fr.inria.papart.depthcam.devices.*;

import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;
import tech.lity.rea.skatolo.gui.widgets.*;

import fr.inria.guimodes.Mode;

import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;

import org.openni.*;

Papart papart;
DepthCameraDevice depthCameraDevice;

MyApp app;
MarkerBoard board;
Camera camera;
ARDisplay cameraDisplay;


ExtrinsicCalibrator calibrator;
ArrayList<ExtrinsicSnapshot> snapshots = new ArrayList<ExtrinsicSnapshot>();

// GUI
Skatolo skatolo;
tech.lity.rea.skatolo.gui.group.Textarea titre;
Textfield inputWidth;
Textfield inputHeight;
tech.lity.rea.skatolo.gui.controllers.Button buttonChangeSize;
tech.lity.rea.skatolo.gui.controllers.Button saveButton;


PixelSelect origin, xAxis, yAxis, corner;
DepthAnalysisPImageView depthAnalysis;
DepthTouchInput touchInput;
PVector image[];

void settings(){
    size(640, 480, P3D);
    // size(1920, 1080, P3D);
}

void setup(){

    // Here we suppose that the color camera matches the depth camera. 
    papart = Papart.seeThrough(this);

    try{
    depthCameraDevice = papart.loadDefaultDepthCamera();

    } catch(CannotCreateCameraException e){
	println("Cannot init/start the camera");
	exit();
    }
    depthCameraDevice.getMainCamera().start();
    depthCameraDevice.getMainCamera().setThread();
    depthCameraDevice.loadDataFromDevice();

    initTouch();

    cameraDisplay = papart.getARDisplay();
    cameraDisplay.reloadCalibration();
    cameraDisplay.manualMode();

    // ARDisplay has no extrinisics, it is the origin. 
    // TODO: check this for Kinect 360
    cameraDisplay.setExtrinsics(new PMatrix3D(
    					      1, 0, 0, 0,
    					      0, 1, 0, 0,
    					      0, 0, 1, 0,
    					      0, 0, 0, 1));

    app = new MyApp();

    calibrator = new ExtrinsicCalibrator(this);
    calibrator.setDefaultDepthCamera();

    papart.startTrackingWithoutThread();
    initGUI();

    //    papart.forceDepthCameraSize();
    //    Mode.add("corners");
}

boolean isUsingAR = false;

void useAR(boolean value){
    isUsingAR = value;

    // if(isUsingAR){
    //     papart.forceCameraSize();
    // } else {
    //     papart.forceDepthCameraSize();
    // }
}



void initTouch(){
    // RGB already started by initKinectCamera()
    // UPDATE: no more thread for nothing ?


    // set the default stereo calibration
    // UPDATE: automatic now
    // depthCameraDevice.setStereoCalibration(Papart.kinectStereoCalib);

    // DepthAnalysisPImageView provides a PImage of the coloured depth.
    depthAnalysis = new DepthAnalysisPImageView(this, depthCameraDevice);

    // load the default plane calibration
    PlaneAndProjectionCalibration calibration = new PlaneAndProjectionCalibration();
    calibration.loadFrom(this, Papart.planeAndProjectionCalib);

    // initialize the touchInput
    touchInput = new DepthTouchInput(this,
                                      depthCameraDevice,
                                      depthAnalysis,
                                      calibration);

    // set the automatic update of the touchInput by the camera
    // depthCameraDevice.setTouch(touchInput);


  for(int i = 0; i < 3; i++){
      println("Setting: " + i  + " " + papart.getTouchCalibration(i));
      touchInput.
	  setTouchDetectionCalibration(i,papart.getTouchCalibration(i));
  }
    
    // // load the touch calibration
    // touchInput.setTouchDetectionCalibration(papart.getDefaultTouchCalibration());
    // touchInput.setTouchDetectionCalibration3D(papart.getDefaultTouchCalibration3D());

    // set the rawDepth tag, to specify that there is no projector.
    touchInput.useRawDepth();
}



void draw(){
    background(255);

    //  Plane using the tracked paper...

    updateDepth();

    if(isUsingAR){
        drawCameraAR();
        // Screen screen = app.getScreen();
        // app.computeScreenPosTransform(camera);
	PlaneCalibration planeCalib = new PlaneCalibration(app.getPlane(), 10);
	PlaneCalibration planeCalibDepth = getPlaneFromPaperViewedByDepth();
        HomographyCalibration homography = findHomographyAR(planeCalib); // , planeCalibDepth);
        drawValidPoints(planeCalib, planeCalibDepth, homography);
        if(toSave)
            save(planeCalibDepth, homography);
	
    } else {
        //  Plane using the depthlected Points...
        drawCameraDepth();
        PlaneCalibration planeCalib = getPlaneFromDepth();

// Check the plane orientation
        if(!planeCalib.orientation(new Vec3D(0, 0, 0))){
            planeCalib.flipNormal();
        }

        HomographyCalibration homography = findHomographyDepth(planeCalib);
        drawValidPointsDepth(planeCalib, homography);
        if(toSave)
            save(planeCalib, homography);
    }

    // Get a 3D plane from the screen location
    drawGUI();
}

void updateDepth(){
    IplImage depthImage = depthCameraDevice.getDepthCamera().getIplImage();
    IplImage colImage = depthCameraDevice.getColorCamera().getIplImage();

    if (colImage == null || depthImage == null) {
	System.out.println("No Image.");
        return;
    }
    try{
	depthAnalysis.update(depthImage, colImage, 1);
    }catch(Exception e)
	{
	    e.printStackTrace();
	}
}

void saveButton(){
    println("SaveButton");
    toSave=  true;
}

void save(PlaneCalibration planeCalib, HomographyCalibration homography){
    // planeCalib.flipNormal();
    planeCalib.moveAlongNormal(planeUp);

    println("SAVE PLANE ONLY");
    planeCalib.saveTo(this, Papart.planeCalib);
    
    PlaneAndProjectionCalibration planeProjCalib = new PlaneAndProjectionCalibration();
    planeProjCalib.setPlane(planeCalib);
    planeProjCalib.setHomography(homography);
    // planeProjCalib.saveTo(this, Papart.planeAndProjectionCalib);

    touchInput.setPlaneAndProjCalibration(planeProjCalib);
    toSave = false;
}


HomographyCalibration findHomographyDepth(PlaneCalibration planeCalib){

   Vec3D[] depth = depthAnalysis.getDepthPoints();

    PVector originScreen = getPositionOf(origin);
    PVector xAxisScreen = getPositionOf(xAxis);
    PVector yAxisScreen = getPositionOf(yAxis);
    PVector cornerScreen = getPositionOf(corner);

    Vec3D originPoint = depth[screenToDepth(originScreen)];
    Vec3D xAxisPoint = depth[screenToDepth(xAxisScreen)];
    Vec3D yAxisPoint = depth[screenToDepth(yAxisScreen)];
    Vec3D cornerPoint = depth[screenToDepth(cornerScreen)];

    PVector originDst = new PVector(0, 0);
    PVector xAxisDst = new PVector(1, 0);
    PVector cornerDst = new PVector(1, 1);
    PVector yAxisDst = new PVector(0, 1);

    HomographyCreator homographyCreator = new HomographyCreator(3, 3, 4);

    homographyCreator.addPoint(toPVector(originPoint), originDst);
    homographyCreator.addPoint(toPVector(xAxisPoint), xAxisDst);
    homographyCreator.addPoint(toPVector(cornerPoint), cornerDst);
    boolean success = homographyCreator.addPoint(toPVector(yAxisPoint), yAxisDst);
    if(success){
        return homographyCreator.getHomography();
    } else {
        // System.err.println("Error in computing the 3D homography");
        return HomographyCalibration.INVALID;
    }
}

public PVector toPVector(Vec3D p) {
    return new PVector(p.x, p.y, p.z);
}


// PlaneCalib is with the depth camera as origin
HomographyCalibration findHomographyAR(PlaneCalibration planeCalib) {

    PVector originDst = new PVector();
    PVector xAxisDst = new PVector(1, 0);
    PVector cornerDst = new PVector(1, 1);
    PVector yAxisDst = new PVector(0, 1);

    HomographyCreator homographyCreator = new HomographyCreator(3, 3, 4);

    // all of this is with the depth as origin
    PVector originOnPlane = getKinectViewOf(origin, planeCalib); //, planeCalibDepth);
    PVector xAxisOnPlane = getKinectViewOf(xAxis, planeCalib); // planeCalibDepth);
    PVector cornerOnPlane = getKinectViewOf(corner, planeCalib); // , planeCalibDepth);
    PVector yAxisOnPlane = getKinectViewOf(yAxis, planeCalib); // planeCalibDepth);

    homographyCreator.addPoint(originOnPlane, originDst);
    homographyCreator.addPoint(xAxisOnPlane, xAxisDst);
    homographyCreator.addPoint(cornerOnPlane, cornerDst);
    boolean success = homographyCreator.addPoint(yAxisOnPlane, yAxisDst);
    if(success){
        return homographyCreator.getHomography();
    } else {
        // System.err.println("Error in computing the 3D homography");
        return HomographyCalibration.INVALID;
    }
}

PVector getKinectViewOf(PixelSelect widget,
			PlaneCalibration planeCalib){
    
    PVector posOnScreen = getPositionOf(widget);
    PVector posOnPlane = cameraDisplay.getProjectedPointOnPlane(planeCalib,
                                                                posOnScreen.x / width,
                                                                posOnScreen.y / height);
    // return posOnPlane;
    
    // We have pos on plane from the camera, we convert it to plane
    // to plane on depth.

    // muliply by the extr ?
    PVector posOnPlaneByDepth = new PVector();
    PMatrix3D extr = depthCameraDevice.getStereoCalibrationInv();
    extr.mult(posOnPlane, posOnPlaneByDepth);

    return posOnPlaneByDepth;
}

PVector getPositionOf(PixelSelect widget){
    float[] pos = widget.getArrayValue();
    return new PVector(pos[0], pos[1]);
}

boolean toSave = false;

void keyPressed() {

    if(key == 'd'){

        float[] originPos = origin.getArrayValue();
        println("Originpos " + originPos[0] + " " + originPos[1]);
    }

    if(key =='s'){
        toSave = true;
    }


    if (Mode.is("corners")) {

        if (key != CODED) {
            origin.setKeyboardControlled(false);
            xAxis.setKeyboardControlled(false);
            corner.setKeyboardControlled(false);
            yAxis.setKeyboardControlled(false);

            if (key == '1')
                origin.setKeyboardControlled(true);

            if (key == '2')
                xAxis.setKeyboardControlled(true);

            if (key == '3')
                corner.setKeyboardControlled(true);

            if (key == '4')
                yAxis.setKeyboardControlled(true);
        }
    }


    if (key == 'a') {
        addLocation();
        println("Added new position, total: " + snapshots.size());
    }

    if(key == 'c'){


        try{
            boolean working = calibrator.calibrateDepthCamPlane(snapshots);
            println("Calibration: " + (working? "OK": "ERROR") + " .");
        }catch(Exception e){
            e.printStackTrace();
        }

    }
}


void addLocation(){

    try{
        board = app.getBoard();
        camera = papart.getCameraTracking();

        println("Board " + board);
        println("cam" + camera);
        snapshots.add(new ExtrinsicSnapshot(
                          null,
                          null,
                          board.getTransfoMat(camera).get()));
    }catch(Exception e){
        e.printStackTrace();
    }
}

void clearLocations(){
    snapshots.clear();
}
