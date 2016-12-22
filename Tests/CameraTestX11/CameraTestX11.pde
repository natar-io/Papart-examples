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
import org.bytedeco.javacv.*;

Camera camera;
CameraRGBIRDepth cameraMulti;

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
    camera = CameraFactory.createCamera(Camera.Type.FFMPEG, ":0.0+1280,0", "x11grab");

    //     camera.setSize(400, 400);
    camera.setSize(1024, 768);
    
     // camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0");
     // cameraMulti = (CameraRGBIRDepth) camera;
    // camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0", "rgb");
	//	camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0", "rgb");
	// camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT_2, "0", "rgb");

    //	cameraMulti = (CameraRGBIRDepth) camera;
	//	cameraMulti.actAsColorCamera();

    //	cameraMulti.setUseDepth(true);
	// cameraMulti.setUseColor(true);
	//	cameraMulti.setUseIR(true);

    //	cameraMulti.getColorCamera().setSize(1280, 720);
	//	cameraMulti.getColorCamera().setSize(1920, 1080);
	//	cameraMulti.getColorCamera().setFrameRate(15);
	// cameraMulti.getIRCamera().setSize(640, 480);
	

	//	camera.setSize(1280, 720);
	camera.setParent(this);

	//    ((CameraFlyCapture) camera).setBayerDecode(true);
	camera.start();
	//camera.setThread();

    // videoOut = createImage(1280, 720, RGB);
    //    frameRate(1000);
}



// PImage videoOut;
void draw() {

    background(0);

    camera.grab();
    
    PImage im = camera.getPImage();
    if(im != null){
	//	println("image OK");
    	image(im, 0, 0, width, height);
    } else {
	// println("image null");
    }
    
    // }catch(Exception e){
    // 	e.printStackTrace();
    // }
    

    // } catch(Exception e ){
    // 	e.printStackTrace();
    // }
}
