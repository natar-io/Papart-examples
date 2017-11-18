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
    size(800, 600, OPENGL);
    // size(resX, resY, OPENGL);
}



OpenCVFrameConverter cameraFrameConverter = new OpenCVFrameConverter.ToIplImage();

public void setup() {
    
    if (surface != null) {
	surface.setResizable(true);
    }

    try{
	// camera = CameraFactory.createCamera(Camera.Type.FFMPEG, "/dev/video1");
	camera = CameraFactory.createCamera(Camera.Type.FFMPEG,
					    "/home/jiii/my_video-1.mkv", "");
    } catch(CannotCreateCameraException cce){
	println("Cannot create the camera...");
    }
    
    camera.setSize(640, 480);
    // camera.setSize(800, 600);
    camera.setParent(this);
    
    camera.start();
    //camera.setThread();
}

void draw() {
    //    background(0);
    camera.grab();

    PImage im = camera.getPImage();
    if(im != null){
	//	println("image OK");
    	image(im, 0, 0, width, height);
    } else {
	// println("image null");
    }

}
