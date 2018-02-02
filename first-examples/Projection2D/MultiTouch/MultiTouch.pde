import fr.inria.papart.procam.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.tracking.*;

import org.bytedeco.javacv.*;
import toxi.geom.*;

import org.openni.*;

DepthTouchInput touchInput;

void settings(){
    fullScreen(P3D);
}

void setup(){
    Papart papart = Papart.projection2D(this);
    // arguments are 2D and 3D precision.
    papart.loadTouchInput();
    touchInput = (DepthTouchInput) papart.getTouchInput();
    
    papart.startDepthCameraThread();
    
    frameRate(60);
}

void draw(){

    //    println("Framerate "+ frameRate);

    background(0, 0, 5);

    fill(50, 50, 255);

    // fill(255, 0, 0);
    // ArrayList<TrackedDepthPoint> touchs3D = new ArrayList<TrackedDepthPoint>(touchInput.getTrackedDepthPoints3D());
    // for(TrackedDepthPoint tp : touchs3D){
    // 	PVector pos = tp.getPosition();
    // 	ellipse(pos.x * width,
    // 		pos.y * height, 40, 40);
    // }


    colorMode(HSB, 30);
    // Get a copy, as the arrayList is constantly modified
    ArrayList<TrackedDepthPoint> touchs2D = new ArrayList<TrackedDepthPoint>(touchInput.getTrackedDepthPoints2D());
    for(TrackedDepthPoint tp : touchs2D){
	fill(tp.getID(), 30, 30);
	PVector pos = tp.getPosition();
	ellipse(pos.x * width,
		pos.y * height, 20, 20);
    }

}
