// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.opencv.opencv_core.*;
import toxi.geom.*;
import org.openni.*;

Camera video;

void settings() {
  size(640, 480, P3D);
}

void setup() {
    try{
	video = CameraFactory.createCamera(Camera.Type.FFMPEG, "/home/ditrop/Documents/chat-fr.mp4");
	video.setParent(this);
	((CameraFFMPEG)video).startVideo();
    } catch(CannotCreateCameraException cce){
	println("Cannot load the camera: " + cce);
    }
} 

void draw() {
    video.grab();
    PImage im = video.getPImage();
    if (im != null) {
	image(im, 0, 0, width, height);
    }
    
}
