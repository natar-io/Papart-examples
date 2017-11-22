import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;

import toxi.geom.*;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.freenect;
import org.bytedeco.javacpp.opencv_core.*;


import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.*;
import tech.lity.rea.skatolo.gui.group.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import processing.video.*;

import java.awt.DisplayMode;
import java.awt.GraphicsDevice;
import org.bytedeco.javacv.CanvasFrame;

import java.io.*;
import java.nio.channels.FileChannel;


Skatolo skatolo;

CameraConfiguration cameraConfig;
CameraConfiguration depthCameraConfig;
ScreenConfiguration screenConfig;

int nbScreens = 1;
PImage backgroundImage;

public void settings() {
    size(800, 840);
}

TestView testView;

void setup(){

    cameraConfig = new CameraConfiguration();
    depthCameraConfig = new CameraConfiguration();
    screenConfig = new ScreenConfiguration();

    cameraConfig.loadFrom(this, Papart.cameraConfig);
    depthCameraConfig.loadFrom(this, Papart.depthCameraConfig);
    screenConfig.loadFrom(this, Papart.screenConfig);

    initUI();
    backgroundImage = loadImage("data/background.png");
    tryLoadCameraCalibration();
    tryLoadProjectorCalibration();

    // test subApplet.
    testView = new TestView();
}

public void dispose(){
    testView.dispose();
    super.dispose();
}

int cameraWidth, cameraHeight;
int projectorWidth, projectorHeight;
boolean cameraCalibrationOk = false;
boolean projectorCalibrationOk = false;

void tryLoadCameraCalibration(){
    try{
	String calibrationYAML = Papart.cameraCalib;
	ProjectiveDeviceP pdp = ProjectiveDeviceP.loadCameraDevice(this, calibrationYAML);
	cameraWidth = pdp.getWidth();
	cameraHeight = pdp.getHeight();
	cameraCalibrationOk = true;
	println(cameraWidth + " " + cameraHeight);
    } catch(Exception e){

    }
}

void tryLoadProjectorCalibration(){
    try{
	String calibrationYAML = Papart.projectorCalib;
	ProjectiveDeviceP pdp = ProjectiveDeviceP.loadProjectorDevice(this, calibrationYAML);
	projectorWidth = pdp.getWidth();
        projectorHeight = pdp.getHeight();
        projectorCalibrationOk = true;
	//println(cameraWidth + " " + cameraHeight);
    } catch(Exception e){

    }
}

void testProjection(boolean value){
    if(value){
	testView.testProjector();
    }
}

void testCameraButton(boolean value){
    println("Start pressed " + value);

    if(value){
	testView.testCamera();
    }

}


void cameraTypeChooser(int value){
    if(value >= 0){
        cameraConfig.setCameraType(Camera.Type.values()[value]);
    }

    if(value == Camera.Type.FFMPEG.ordinal()){
        cameraFormatText.show();
    } else {
        cameraFormatText.hide();
    }

    if(value == Camera.Type.REALSENSE.ordinal() ||
       value == Camera.Type.OPEN_KINECT.ordinal() ||
       value == Camera.Type.OPEN_KINECT_2.ordinal()){
	cameraSubType.show();

	int currentType = getDepthType(value);
	depthCameraType.activate(currentType);
	
    } else {
	cameraSubType.hide();
    }

}

void depthCameraTypeChooser(int value){
    if(value >= 0){
        depthCameraConfig.setCameraType(Camera.Type.values()[value]);
    }
}

void testDepthCameraButton(boolean value){

    if(value){
	testView.testDepthCamera();
    }

}

void screenChooserRadio(int value){

    if(value > 0 && value < nbScreens){
	PVector resolution = getScreenResolution(value);
	screenConfig.setProjectionScreenWidth((int) resolution.x);
	screenConfig.setProjectionScreenHeight((int) resolution.y);
	println("screen chooser radio");
    }
}

PVector getScreenResolution(int screenNo){
    DisplayMode displayMode = CanvasFrame.getDisplayMode(screenNo);
    return new PVector(displayMode.getWidth(), displayMode.getHeight());
}


int rectSize = 30;

void draw(){

        // cColor = new CColor(color(49,51,50),
    // 	       color(51),
    // 	       color(71),
    // 	       color(255),
    // 	       color(255));

     // initCameraUI();
     // updateStyles();

    image(backgroundImage, 0, 0);

    if(cameraCalibrationOk){
        text("Resolution: " + cameraWidth + "x" + cameraHeight , 400, 432);
    }

    if(projectorCalibrationOk){
        text("Resolution: " + projectorWidth + "x" + projectorHeight ,350, 209);
    }


}



void keyPressed() {
    // if (key == 27) {
    // 	//The ASCII code for esc is 27, so therefore: 27
    //  //insert your function here
    // }
    // if (key == ESC)
    //     key=0;

}



void loadCalibration(){
    File defaultCameraCalibration = new File(Papart.cameraCalib);
    selectOutput("Choose the calibration YAML file:", "fileSelectedLoadCalibration", defaultCameraCalibration);
}

// TODO custom file chooser...
void fileSelectedLoadCalibration(File selection){

    if(selection == null){
        return;
    }

    if(selection.getName().endsWith(".yaml")){
        File defaultCameraCalibration = new File(Papart.cameraCalib);
        try{
            copy(selection, defaultCameraCalibration);

            tryLoadCameraCalibration();
            println("New calibration set! ");

        } catch(Exception e){
            println("Error while copying file " + e);
        }
    }else {
        println("You should select a YAML calibration file");
    }
}


public void copy(File src, File dst) throws IOException {
    FileInputStream inStream = new FileInputStream(src);
    FileOutputStream outStream = new FileOutputStream(dst);
    FileChannel inChannel = inStream.getChannel();
    FileChannel outChannel = outStream.getChannel();
    inChannel.transferTo(0, inChannel.size(), outChannel);
    inStream.close();
    outStream.close();
}

void saveDefaultCamera(){
    saveCamera(Papart.cameraConfig);
    saveCamera("camera-config.xml");
}

void saveCamera(String fileName){
    cameraConfig.setCameraName(cameraIdText.getText());
    setFormat();

    cameraConfig.saveTo(this, fileName);
    println("Camera saved.");
}

void setFormat(){
    if(cameraType.getValue() == Camera.Type.FFMPEG.ordinal()){
	cameraConfig.setCameraFormat(cameraFormatText.getText());
    }
    
    if(cameraType.getValue() == Camera.Type.REALSENSE.ordinal() ||
       cameraType.getValue() == Camera.Type.OPEN_KINECT.ordinal() ||
       cameraType.getValue() == Camera.Type.OPEN_KINECT_2.ordinal()){
	
	switch((int) cameraSubType.getValue()){
	case RGB_FORMAT:
	    cameraConfig.setCameraFormat("rgb");
	    break;
	case IR_FORMAT:
	    cameraConfig.setCameraFormat("ir");
	    break;
	case DEPTH_FORMAT:
	    cameraConfig.setCameraFormat("depth");
	    break;
	default:
	    throw new RuntimeException("Cannot set different value");
	}
    }
}


void fileSelectedSaveDepthCamera(File selection) {
    saveDepthCamera(selection.getAbsolutePath());
}

void saveDefaultDepthCamera(){
    saveDepthCamera(Papart.depthCameraConfig);
    saveDepthCamera("depth-camera-config.xml");
}

void saveDepthCamera(String fileName){
    depthCameraConfig.setCameraName(depthCameraIdText.getText());
    depthCameraConfig.saveTo(this, fileName);
    println("DepthCamera saved.");
}



void loadProjectorCalibration(){
    File defaultProjectorCalibration = new File(Papart.projectorCalib);
    selectOutput("Choose the projectorCalibration YAML file:",
                 "fileSelectedLoadProjectorCalibration",
                 defaultProjectorCalibration);
}

// TODO custom file chooser...
void fileSelectedLoadProjectorCalibration(File selection){

    if(selection == null){
        return;
    }
    if(selection.getName().endsWith(".yaml")){
        File defaultProjectorCalibration = new File(Papart.projectorCalib);
        try{
            copy(selection, defaultProjectorCalibration);
            tryLoadProjectorCalibration();
            println("New projector calibration set! ");
        } catch(Exception e){
            println("Error while copying file " + e);
        }
    }else {
        println("You should select a YAML projector calibration file");
    }
}

void saveDefaultScreen(){
    saveScreen(Papart.screenConfig);
}

void updateScreenConfig(){
    try{
	screenConfig.setProjectionScreenOffsetX(Integer.parseInt(posXText.getText()));
	screenConfig.setProjectionScreenOffsetY(Integer.parseInt(posYText.getText()));
    }catch(java.lang.NumberFormatException e){
	println("Invalid Position");
    }
}

void saveScreen(String fileName){

    updateScreenConfig();

    screenConfig.saveTo(this, fileName);
    println("Default screen saved.");
}
