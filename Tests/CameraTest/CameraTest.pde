// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;

import org.bytedeco.javacv.RealSenseFrameGrabber;
import processing.video.*;
CameraRealSense cameraRS;


Camera camera;
int resX = 640;
int resY = 480;

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

     camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0");
     cameraRS = (CameraRealSense) camera;
    
    camera.setParent(this);
    camera.setSize(resX, resY);
    //    ((CameraFlyCapture) camera).setBayerDecode(true);
    camera.start();
    camera.setThread();

}

void draw() {

    PImage imRGB = cameraRS.getColorImage();
    PImage imIR = cameraRS.getIRImage();
    PImage imDepth = cameraRS.getDepthPImage();
    //	PImage im = camera.getPImage();
    if(imRGB != null){
	image(imRGB, 0, 0, 640, 480);
    }
    if(imIR != null){
	image(imIR, 640, 0, 640, 480);
    }
    if(imDepth != null){
	image(imDepth, 0, 480, 640, 480);
    }
}
