// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacv.RealSenseFrameGrabber;
import processing.video.*;

import org.bytedeco.javacv.Frame;
import fr.inria.papart.procam.Utils;
import org.bytedeco.javacv.*;

Camera camera;
CameraRGBIRDepth cameraRS;
CameraOpenKinect cameraK;

int resX = 512;
int resY = 424;

void settings(){
    size(640 * 2, 480 * 2, OPENGL);
    // size(resX, resY, OPENGL);
}


OpenCVFrameConverter cameraFrameConverter = new OpenCVFrameConverter.ToIplImage();

public void setup() {
    
    if (surface != null) {
	surface.setResizable(true);
    }

    // camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0");
    // camera = CameraFactory.createCamera(Camera.Type.OPENCV, "0");
    // camera = CameraFactory.createCamera(Camera.Type.PROCESSING, "/dev/video1");
    // camera = CameraFactory.createCamera(Camera.Type.FLY_CAPTURE, 0);

    // camera = CameraFactory.createCamera(Camera.Type.FFMPEG, "/dev/video1");
    // camera = CameraFactory.createCamera(Camera.Type.FFMPEG, ":0.0+200,200", "x11grab");

     // camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0");
     // cameraRS = (CameraRGBIRDepth) camera;
    // cameraK = (CameraOpenKinect) camera;
    // cameraK.getIRVideo();

    camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0", "");
    // camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0", "depth");
    // camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT_2, "0", "rgb");
    
    cameraRS = (CameraRGBIRDepth) camera;
    //	cameraRS.actAsColorCamera();
    
    //	cameraRS.setUseDepth(true);
    cameraRS.setUseColor(true);
    //	cameraRS.setUseIR(true);
    
    // cameraRS.getColorCamera().setSize(1280, 720);
    // cameraRS.getIRCamera().setSize(640, 480);
    
    //	camera.setSize(640, 480);
    //	camera.setSize(1280, 720);
    camera.setParent(this);
    
    
    //    ((CameraFlyCapture) camera).setBayerDecode(true);
    camera.start();
    //camera.setThread();
    
    videoOut = createImage(1280, 720, RGB);
    //    frameRate(1000);
}



PImage videoOut;
void draw() {

    background(0);

    Frame camFrame = ((CameraRealSense)camera).grabFrame();
    if(camFrame == null)
	return;

    IplImage iplFrame = (IplImage) cameraFrameConverter.convert(camFrame);
    Utils.IplImageToPImage(iplFrame, true, videoOut);
    image(videoOut, 0, 0, width, height);
 
    // IplImage imI = camera.getIplImage();
    // fr.inria.papart.procam.Utils.IplImageToPImage(imI, true, videoOut);
    
    // PImage im = camera.getPImage();
    // if(im != null){
    // 	println("image OK");
    // 	image(im, 0, 0, width, height);
    // } else {
    // 	println("image null");
    // }
    
    // }catch(Exception e){
    // 	e.printStackTrace();
    // }



    
    // PImage imRGB = cameraRS.getColorImage();
    // PImage imIR = cameraRS.getIRImage();
    // PImage imDepth = cameraRS.getDepthPImage();
    
    // if(imRGB != null){
    // 	image(imRGB, 0, 0, 640, 480);
    // }
    // if(imIR != null){
    // 	image(imIR, 640, 0, 640, 480);
    // }
    // if(imDepth != null){
    // 	image(imDepth, 0, 480, 640, 480);
    // }



    
    // } catch(Exception e ){
    // 	e.printStackTrace();
    // }
}
