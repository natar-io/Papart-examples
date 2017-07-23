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

Camera camera, camera0;
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

    camera = CameraFactory.createCamera(Camera.Type.FFMPEG, "/home/jiii/ownCloud/realityTech/presentations/papart.mp4");
    // camera = CameraFactory.createCamera(Camera.Type.FFMPEG, ":0.0+200,200", "x11grab");
    camera.setParent(this);
    
    ((CameraFFMPEG)camera).startVideo();

    videoOut = createImage(camera.width(),
			   camera.height(),
			   RGB);
    // camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0");
     // cameraRS = (CameraRGBIRDepth) camera;
    // cameraK = (CameraOpenKinect) camera;
    // cameraK.getIRVideo();

    // try{
    //     // camera0 = CameraFactory.createCamera(Camera.Type.OPENCV, "0", "");
    // 	// camera0.setSize(1920, 1080);
    // 	// camera0.setParent(this);
    // 	// camera0.start();

    // 	camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0", "");
    // 	// camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0", "depth");
    // 	// camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT_2, "0", "rgb");

    // 	cameraRS = (CameraRGBIRDepth) camera;
    // 	//	cameraRS.actAsColorCamera();

    // 	cameraRS.setUseDepth(true);self,self,
    // 	cameraRS.setUseColor(true);
    // 	// cameraRS.setUseIR(true);

    // 	// cameraRS.getColorCamera().setSize(1280, 720);
    // 	//	cameraRS.getColorCamera().setSize(1920, 1080);
    // 	// cameraRS.getColorCamera().setFrameRate(60);
	
    // 	// cameraRS.getIRCamera().setSize(640, 480);
    // 	// // cameraRS.getIRCamera().setFrameRate(200);
	
    // 	// cameraRS.getDepthCamera().setSize(640, 480);
    // 	// cameraRS.getDepthCamera().setFrameRate(30);

    // 	//	camera.setSize(1280, 720);
    // 	camera.setParent(this);


    // 	//    ((CameraFlyCapture) camera).setBayerDecode(true);
    // 	camera.start();
    // 	//camera.setThread();

    //     } catch(Exception e ){
    // 	e.printStackTrace();
    // }


    //    frameRate(1000);
}

PImage videoOut;
void draw() {

    //    background(0);

    //    camera0.grab();
    camera.grab();

    try{
    // IplImage imI = camera.getIplImage();
    // if(imI != null){
    // 	fr.inria.papart.utils.ImageUtils.IplImageToPImage(imI, false, videoOut);
    // 	image(videoOut, 0, 0, width, height);
    // }
    PImage im = camera.getPImage();
    if(im != null){
    	println("image OK");
    	image(im, 0, 0, width, height);
    } else {
    	println("image null");
    }
    
    }catch(Exception e){
    	e.printStackTrace();
    }

    // PImage imRGB = cameraRS.getColorImage();

    // //    PImage imRGB = camera0.getPImage();
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
