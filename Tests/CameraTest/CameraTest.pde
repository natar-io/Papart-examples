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

Camera camera;
CameraRGBIRDepth cameraRS;
CameraOpenKinect cameraK;

int resX = 512;
int resY = 424;

void settings(){
    size(640 * 2, 480 * 2, OPENGL);
    // size(resX, resY, OPENGL);
}

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

    // camera = CameraFactory.createCamera(Camera.Type.REALSENSE_RGB, "0");
    // camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT_2_RGB, "0");

    try{
    camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0");
    cameraRS = (CameraRGBIRDepth) camera;
    camera.setParent(this);

    } catch(Exception e ){
	e.printStackTrace();
    }

    // camera.setSize(resX, resY);
    //    ((CameraFlyCapture) camera).setBayerDecode(true);
    camera.start();
    // camera.setThread();

    //    videoOut = createImage(resX, resY, RGB);
    //    frameRate(1000);
}

PImage videoOut;
void draw() {

    background(0);
    camera.grab();
    
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
    
    PImage imRGB = cameraRS.getColorImage();
    PImage imIR = cameraRS.getIRImage();
    PImage imDepth = cameraRS.getDepthPImage();

    if(imRGB != null){
    	image(imRGB, 0, 0, 640, 480);
    }
    if(imIR != null){
    	image(imIR, 640, 0, 640, 480);
    }
    if(imDepth != null){
    	image(imDepth, 0, 480, 640, 480);
    } else {
	println("Depth Image null");
    }
}
