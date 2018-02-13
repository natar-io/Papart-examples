import fr.inria.papart.depthcam.DepthData;
import java.util.ArrayList;
import toxi.geom.Vec3D;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.multitouch.tracking.*;

import fr.inria.papart.depthcam.devices.*;

boolean test = false;
void keyPressed() {
  if (key == 't')
    test = !test;
}

public class MyApp extends PaperTouchScreen {

  PMatrix3D depthCamExtrinsics;
  PMatrix3D currentLocationInv; 
  
  void settings() {
    setDrawAroundPaper();
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
  }

  void setup() {
    DepthCameraDevice depthCamera = papart.getDepthCameraDevice();
    // depthCamExtrinsics = depthCamera.getDepthCamera().getExtrinsics().get();
    depthCamExtrinsics = depthCamera.getStereoCalibration();
    
    depthCamExtrinsics.print();
    //depthCamExtrinsics.invert();
    // Projector extrinsics
    //PMatrix3D projExtrinsics = papart.loadCalibration(Papart.cameraProjExtrinsics);
    //projExtrinsics.invert();
    //depthCamExtrinsics.apply(projExtrinsics);
  }

  void drawAroundPaper() {

    // Go to the origin of the projection
    translate(0, getDrawingSize().y);
    scale(1, -1, 1);

    currentLocationInv = getLocation().get();
    currentLocationInv.invert();

   rect(0, 0, 10, 20);
    noStroke();
    for (Touch t : touchList) {
      PVector p = t.position;
      TrackedDepthPoint tp = (TrackedDepthPoint) t.trackedSource();
      if (tp == null) {
        println("TrackedDepthPoint null, this method only works with DepthtTouchInput.");
        continue;
      }

      ArrayList<DepthDataElementProjected> depthDataElements = tp.getDepthDataElements();
      for (DepthDataElementProjected dde : depthDataElements) {
        drawPoint(dde);
      }
    }
  }

  float ellipseSize = 4;
  void drawPoint(DepthDataElementProjected dde) {

    Vec3D depthPoint = dde.depthPoint;
    PVector pointPosExtr = new PVector();
    PVector pointPosDisplay = new PVector();
    depthCamExtrinsics.mult(new PVector(depthPoint.x, 
      depthPoint.y, 
      depthPoint.z), 
      pointPosExtr);

    currentLocationInv.mult(pointPosExtr, 
      pointPosDisplay);

    pushMatrix();

    //fill(pointPosDisplay.z * 2);
    fill(200);
    translate(pointPosDisplay.x, pointPosDisplay.y, pointPosDisplay.z );
    ellipse(-1, -1, ellipseSize, ellipseSize);
    popMatrix();
  }
}