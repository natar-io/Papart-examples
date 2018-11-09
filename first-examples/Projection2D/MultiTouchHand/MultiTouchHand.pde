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

void settings(){
    fullScreen(P3D);
}

void setup(){

    Papart papart = Papart.projection2D(this);
    // arguments are 2D and 3D precision.
    papart.loadTouchInput();
    touchInput = (DepthTouchInput) papart.getTouchInput();
    touchInput.initHandDetection();
    papart.startDepthCameraThread();
}


void draw(){

    background(10);

    fill(50, 50, 255);

    if(!touchInput.isReady()){
	return;
    }

    FingerDetection fingerDetection = touchInput.getFingerDetection();
    HandDetection handDetection = touchInput.getHandDetection();
    ArmDetection armDetection = touchInput.getArmDetection();
    
    // Get a copy, as the arrayList is constantly modified
    ArrayList<TrackedDepthPoint> fingerTouch = (ArrayList<TrackedDepthPoint>)fingerDetection.getTouchPoints().clone();
    for(TrackedDepthPoint tp : fingerTouch){
        ArrayList<DepthDataElementProjected> depthDataElements = tp.getDepthDataElements();
        for(DepthDataElementProjected dde : depthDataElements){
            Vec3D v = dde.projectedPoint;
            noStroke();
            setColor(dde.pointColor, 255);
            ellipse(v.x * width,
        	    v.y * height,
        	    10, 10);
        }
        fill(50, 50, 255);
        PVector pos = tp.getPosition();
        ellipse(pos.x * width,
        	pos.y * height, 20, 20);
    }


    ArrayList<TrackedDepthPoint> armTouch = (ArrayList<TrackedDepthPoint>)armDetection.getTouchPoints().clone();
    //    ArrayList<TrackedDepthPoint> armTouch = (ArrayList<TrackedDepthPoint>)handDetection.getTouchPoints().clone();
    for(TrackedDepthPoint tp : armTouch){

        ArrayList<DepthDataElementProjected> depthDataElements = tp.getDepthDataElements();

        for(DepthDataElementProjected dde : depthDataElements){
            Vec3D v = dde.projectedPoint;
            noStroke();
            setColor(dde.pointColor, 100);

            ellipse(v.x * width,
        	    v.y * height,
        	    10, 10);
        }

        PVector pos = tp.getPosition();
        ellipse(pos.x * width,
        	pos.y * height, 40, 40);
    }



}

void setColor(int rgb, float intens){
    int r = (rgb >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (rgb >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = rgb & 0xFF;          // Faster way of getting blue(argb)
    fill(r, g, b, intens);
}
