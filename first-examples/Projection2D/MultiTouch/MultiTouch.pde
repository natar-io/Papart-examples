import fr.inria.papart.procam.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

import org.bytedeco.javacv.*;
import toxi.geom.*;

import org.openni.*;
import redis.clients.jedis.*;

DepthTouchInput touchInput;
Simple2D simpleTouchDetection;
    
void settings(){
    fullScreen(P3D);
}

void setup(){
    Papart papart = Papart.projection2D(this);
    // arguments are 2D and 3D precision.
    simpleTouchDetection = papart.loadTouchInput().initSimpleTouchDetection();
    touchInput = (DepthTouchInput) papart.getTouchInput();
    papart.startDepthCameraThread();
    frameRate(60);
}

void draw(){

    //    println("Framerate "+ frameRate);

    background(0, 0, 5);

    fill(50, 50, 255);

    colorMode(HSB, 30);
    // Get a copy, as the arrayList is constantly modified
    ArrayList<TrackedDepthPoint> touchs2D = new ArrayList<TrackedDepthPoint>(simpleTouchDetection.getTouchPoints());
    for(TrackedDepthPoint tp : touchs2D){
	fill(tp.getID(), 30, 30);
	PVector pos = tp.getPosition();
	ellipse(pos.x * width,
		pos.y * height, 20, 20);
    }

}
