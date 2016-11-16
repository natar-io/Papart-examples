import fr.inria.papart.multitouch.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.tracking.*;
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.depthcam.analysis.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.calibration.*;

import fr.inria.skatolo.*;
import fr.inria.skatolo.events.*;
import fr.inria.skatolo.gui.controllers.*;
import fr.inria.skatolo.gui.widgets.*;

import fr.inria.guimodes.Mode;

import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import tech.lity.rea.svgextended.PShapeSVGExtended;

Papart papart;
DepthCameraDevice depthCameraDevice;

MyApp app;
MarkerBoard board;
Camera camera;
ARDisplay cameraDisplay;


CalibrationExtrinsic calibrationExtrinsic;
ArrayList<CalibrationSnapshot> snapshots = new ArrayList<CalibrationSnapshot>();

// GUI
Skatolo skatolo;
fr.inria.skatolo.gui.group.Textarea titre;
Textfield inputWidth;
Textfield inputHeight;
fr.inria.skatolo.gui.controllers.Button buttonChangeSize;
fr.inria.skatolo.gui.controllers.Button saveButton;


PixelSelect origin, xAxis, yAxis, corner;
KinectProcessing depthAnalysis;
KinectTouchInput touchInput;
PVector image[];

void settings(){
    size(640, 480, P3D);
    // size(1920, 1080, P3D);
}

void setup(){

    // Here we suppose that the color camera matches the depth camera. 
    papart = Papart.seeThrough(this);
    depthCameraDevice = papart.loadDefaultDepthCamera();
    
    // todo: assert to verify that. 
    //    papart.initKinectCamera(1);
    //   frame.setResizable(false);

   initTouch();

    cameraDisplay = papart.getARDisplay();
    cameraDisplay.manualMode();
    cameraDisplay.setExtrinsics(new PMatrix3D());

    app = new MyApp();

    calibrationExtrinsic = new CalibrationExtrinsic(this);
    calibrationExtrinsic.setDefaultKinect();

    papart.startTracking();
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
    depthCameraDevice.getDepthCamera().setThread();

    // set the default stereo calibration
    // UPDATE: automatic now
    // depthCameraDevice.setStereoCalibration(Papart.kinectStereoCalib);

    // KinectProcessing provides a PImage of the coloured depth.
    depthAnalysis = new KinectProcessing(this, depthCameraDevice);

    // load the default plane calibration
    PlaneAndProjectionCalibration calibration = new PlaneAndProjectionCalibration();
    calibration.loadFrom(this, Papart.planeAndProjectionCalib);

    // initialize the touchInput
    touchInput = new KinectTouchInput(this,
                                      depthCameraDevice,
                                      depthAnalysis,
                                      calibration);

    // set the automatic update of the touchInput by the camera
    // depthCameraDevice.setTouch(touchInput);

    // load the touch calibration
    touchInput.setTouchDetectionCalibration(papart.getDefaultTouchCalibration());
    touchInput.setTouchDetectionCalibration3D(papart.getDefaultTouchCalibration3D());

    // set the rawDepth tag, to specify that there is no projector.
    touchInput.useRawDepth();
}



void draw(){
    background(255);

    //  Plane using the tracked paper...

    updateDepth();

    if(isUsingAR){
        drawCameraAR();
        Screen screen = app.getScreen();
        screen.computeScreenPosTransform(camera);
        PlaneCalibration planeCalib = getPlaneFromPaper();
        HomographyCalibration homography = findHomographyAR(planeCalib);
        drawValidPoints(planeCalib, homography);
        if(toSave)
            save(planeCalib, homography);
	
    } else {
        //  Plane using the selected Points...
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
    depthAnalysis.update(depthImage, colImage, 1);
}

void saveButton(){
    println("SaveButton");
    toSave=  true;
}

void save(PlaneCalibration planeCalib, HomographyCalibration homography){
    // planeCalib.flipNormal();
    planeCalib.moveAlongNormal(planeUp);

    PlaneAndProjectionCalibration planeProjCalib = new PlaneAndProjectionCalibration();
    planeProjCalib.setPlane(planeCalib);
    planeProjCalib.setHomography(homography);
    planeProjCalib.saveTo(this, Papart.planeAndProjectionCalib);

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


HomographyCalibration findHomographyAR(PlaneCalibration planeCalib){

    PVector originDst = new PVector();
    PVector xAxisDst = new PVector(1, 0);
    PVector cornerDst = new PVector(1, 1);
    PVector yAxisDst = new PVector(0, 1);

    HomographyCreator homographyCreator = new HomographyCreator(3, 3, 4);

    PVector originOnPlane = getKinectViewOf(origin, planeCalib);
    PVector xAxisOnPlane = getKinectViewOf(xAxis, planeCalib);
    PVector cornerOnPlane = getKinectViewOf(corner, planeCalib);
    PVector yAxisOnPlane = getKinectViewOf(yAxis, planeCalib);

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

PVector getKinectViewOf(PixelSelect widget, PlaneCalibration planeCalib){
    PVector posOnScreen = getPositionOf(widget);
    PVector posOnPlane = cameraDisplay.getProjectedPointOnPlane(planeCalib,
                                                                posOnScreen.x / width,
                                                                posOnScreen.y / height);
    return posOnPlane;
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
            boolean working = calibrationExtrinsic.calibrateKinect360Plane(snapshots);
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
        snapshots.add(new CalibrationSnapshot(
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
