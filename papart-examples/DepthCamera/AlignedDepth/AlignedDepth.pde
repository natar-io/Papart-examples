import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.depthcam.analysis.*;

import org.bytedeco.javacv.*;
import org.bytedeco.javacpp.opencv_core.*;
import org.bytedeco.javacpp.freenect;
import toxi.geom.*;
import peasy.*;

PeasyCam cam;

KinectPointCloud pointCloud;

KinectProcessing kinectAnalysis;
KinectDevice kinectDevice;

int skip = 2;

void settings(){
    size(640, 480, P3D);
}

void setup(){

    Papart papart = new Papart(this);
    // load the depth camera
    papart.startDefaultKinectCamera();

    kinectDevice = papart.getKinectDevice();
    kinectAnalysis = new KinectProcessing(this, kinectDevice);
}


void draw(){
    background(100);
    // retreive the camera image.
    try {
        kinectDevice.getCameraRGB().grab();
        kinectDevice.getCameraDepth().grab();
    } catch(Exception e){
	println("Could not grab the image " + e);
    }

    IplImage colourImg = kinectDevice.getCameraRGB().getIplImage();
    IplImage depthImg = kinectDevice.getCameraDepth().getIplImage();

    if(colourImg == null || depthImg == null)
	return;

    PImage alignedImage = kinectAnalysis.update(depthImg, colourImg, skip);

    image(alignedImage, 0, 0, width, height);
}

void close(){
    try{
        kinectDevice.close();
    }catch(Exception e){
    }
}