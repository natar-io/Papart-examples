import fr.inria.papart.depthcam.DepthData;
import java.util.ArrayList;
import toxi.geom.Vec3D;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.depthcam.devices.*;

boolean test = false;
void keyPressed(){
    if(key == 't')
        test = !test;
}

public class MyApp extends PaperTouchScreen {

    PMatrix3D depthCameraExtrinsics;

    void settings(){
        setDrawAroundPaper();
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    }

    void setup() {
        DepthCameraDevice depthCamera = papart.getDepthCameraDevice();
        depthCameraExtrinsics = depthCamera.getDepthCamera().getExtrinsics().get();
    }


    void drawAroundPaper(){

        rect(0, 0, 100, 100);
        float ellipseSize = 2;

        PMatrix3D currentLocation = getLocation().get();
        currentLocation.invert();

	// Move the paperScreen origin
	translate(0, drawingSize.y, 0);
	scale(1, -1, 1);
	
        noStroke();

	// TODO: example with more elements: hand and arm.
	
	TouchList touchs = getTouchListFrom(fingerDetection);
	
        for (Touch t : touchs) {

	    PVector p = t.position;
	    if(t.trackedSource == null || !(t.trackedSource instanceof TrackedDepthPoint)){
		println("TouchPoint null, this method only works with DepthTouchInput.");
		continue;
	    }

	    TrackedDepthPoint tracked = (TrackedDepthPoint) t.trackedSource;
	    DepthElementList depthData = tracked.getDepthDataElements();
	    for(DepthDataElementProjected dde : depthData){

                Vec3D depthPoint = dde.depthPoint;
                PVector pointPosExtr = new PVector();
                PVector pointPosDisplay = new PVector();

		// Stereo correction
		depthCameraExtrinsics.mult(new PVector(depthPoint.x,
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
    }
}
