import fr.inria.papart.depthcam.DepthData;
import java.util.ArrayList;
import toxi.geom.Vec3D;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.calibration.*;

import fr.inria.papart.depthcam.devices.*;

boolean test = false;
void keyPressed(){
    if(key == 't')
        test = !test;
}

public class MyApp extends PaperTouchScreen {

    PMatrix3D kinectExtrinsics;

    void settings(){
        setDrawAroundPaper();
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);
    }

    void setup() {
        DepthCameraDevice kinect = papart.getDepthCameraDevice();
        kinectExtrinsics = kinect.getDepthCamera().getExtrinsics().get();
//        kinectExtrinsics.invert();
    }


    void drawAroundPaper(){

        rect(0, 0, 100, 100);
        float ellipseSize = 2;

        PMatrix3D currentLocation = getLocation().get();
        currentLocation.invert();

        noStroke();
        for (Touch t : touchList) {

	    PVector p = t.position;
	    TouchPoint tp = t.touchPoint;
	    if(tp == null){
		println("TouchPoint null, this method only works with KinectTouchInput.");
		continue;
	    }

	    ArrayList<DepthDataElementKinect> depthDataElements = tp.getDepthDataElements();
	    for(DepthDataElementKinect dde : depthDataElements){

                Vec3D depthPoint = dde.depthPoint;
                PVector pointPosExtr = new PVector();
                PVector pointPosDisplay = new PVector();
                kinectExtrinsics.mult(new PVector(depthPoint.x,
                                                 depthPoint.y,
                                                 depthPoint.z),
                                     pointPosExtr);

                currentLocation.mult(pointPosExtr,
                                   pointPosDisplay);

                pushMatrix();


                fill(-pointPosDisplay.z * 2);
                translate(pointPosDisplay.x , pointPosDisplay.y, pointPosDisplay.z);
                ellipse(0, 0, 3, 3);
                popMatrix();
	    }

	}
	endDraw();
    }
}
