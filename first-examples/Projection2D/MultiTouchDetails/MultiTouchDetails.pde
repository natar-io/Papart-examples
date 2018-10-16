import fr.inria.papart.procam.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

import org.bytedeco.javacv.*;
import toxi.geom.*;
import peasy.*;
import org.openni.*;

import redis.clients.jedis.*;

DepthTouchInput touchInput;
TouchDetectionDepth fingerDetection;
ArmDetection armDetection;
HandDetection handDetection;
    
void settings(){
    fullScreen(P3D);
}

void setup(){

    Papart papart = Papart.projection2D(this);
    // arguments are 2D and 3D precision.

    fingerDetection = papart.loadTouchInput().initHandDetection();
    touchInput = (DepthTouchInput) papart.getTouchInput();

    // Hand and arm are initialized for the fingerDetection
    armDetection = touchInput.getArmDetection();
    handDetection = touchInput.getHandDetection();
    
    papart.startDepthCameraThread();
}


void draw(){

    background(10);

    fill(50, 50, 255);

    if(!touchInput.isReady()){
	return;
    }



    // Get a copy, as the arrayList is constantly modified
    ArrayList<TrackedDepthPoint> fingers = new ArrayList<TrackedDepthPoint>(fingerDetection.getTouchPoints());

    for(TrackedDepthPoint finger : fingers){

	colorMode(RGB, 255);

        ArrayList<DepthDataElementProjected> depthDataElements = finger.getDepthDataElements();
        for(DepthDataElementProjected dde : depthDataElements){

	    // Projected Point are the points projected in the projector Screen space, on the table.
	    Vec3D v = dde.projectedPoint;
            noStroke();
            setColor(dde.pointColor, 255);
            ellipse(v.x * width,
        	    v.y * height,
        	    10, 10);
        }

	// Debug IDs
	colorMode(HSB, 30, 100, 100);
	fill(finger.getID(), 80, 80);

	//        fill(50, 50, 255);
        PVector pos = finger.getPosition();
        ellipse(pos.x * width,
        	pos.y * height, 20, 20);
    }

    colorMode(RGB, 255);

}

void setColor(int rgb, float intens){
    int r = (rgb >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (rgb >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = rgb & 0xFF;          // Faster way of getting blue(argb)
    fill(r, g, b, intens);
}
