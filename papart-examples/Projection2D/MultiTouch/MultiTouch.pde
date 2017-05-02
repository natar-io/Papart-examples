import fr.inria.papart.procam.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.multitouch.*;

import org.bytedeco.javacv.*;
import toxi.geom.*;


KinectTouchInput touchInput;

void settings(){
    fullScreen(P3D);
}

void setup(){
    Papart papart = Papart.projection2D(this);
    // arguments are 2D and 3D precision.
    papart.loadTouchInput();
    touchInput = (KinectTouchInput) papart.getTouchInput();
    
    papart.startDepthCameraThread();
    
    frameRate(60);
}

void draw(){

    //    println("Framerate "+ frameRate);
    background(100);

    fill(50, 50, 255);

    fill(255, 0, 0);
    ArrayList<TrackedDepthPoint> touchs3D = new ArrayList<TrackedDepthPoint>(touchInput.getTrackedDepthPoints3D());
    for(TrackedDepthPoint tp : touchs3D){
    	PVector pos = tp.getPosition();
    	ellipse(pos.x * width,
    		pos.y * height, 40, 40);
    }

    // Get a copy, as the arrayList is constantly modified
    ArrayList<TrackedDepthPoint> touchs2D = new ArrayList<TrackedDepthPoint>(touchInput.getTrackedDepthPoints2D());
    for(TrackedDepthPoint tp : touchs2D){
	fill(50, 50, 255);
	PVector pos = tp.getPosition();
	ellipse(pos.x * width,
		pos.y * height, 20, 20);
    }

}
