// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.opencv_core;
import toxi.geom.*;
import org.openni.*;

CameraOpenNI2 mainCamera;
Camera colorCamera;
Camera depthCamera;

void settings() {
  size(640 * 2, 480, P3D);
}


void setup() {
    try{
	mainCamera = (CameraOpenNI2) CameraFactory.createCamera(Camera.Type.OPENNI2, "0", "rgb");
	mainCamera.setUseDepth(true);
	mainCamera.setUseColor(true);

	colorCamera = mainCamera.getColorCamera();
	depthCamera = mainCamera.getDepthCamera();
	
	// all sizes are 640x480 by default
	//	camera2.setSize(640, 480);
	mainCamera.setParent(this);
	mainCamera.start();
    } catch(CannotCreateCameraException cce){
	println("Cannot load the camera: " + cce);
    }
} 

void draw() {
    mainCamera.grab();
    PImage im1 = colorCamera.getPImage();
    PImage im2 = depthCamera.getPImage();
    if (im1 != null) {
	image(im1, 0, 0, 640, 480);
    }
	
    if (im2 != null) {
	image(im2, 640, 0, 640, 480);
    }
    
}
