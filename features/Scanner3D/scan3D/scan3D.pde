import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.scanner.*;
import fr.inria.papart.calibration.*;

import fr.inria.papart.depthcam.PointCloud;

import static org.bytedeco.javacpp.opencv_core.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.openni.*;
import fr.inria.papart.scanner.GrayCode;
import fr.inria.papart.scanner.*;

import peasy.*;
PeasyCam cam;


void settings(){
    size(800, 600, OPENGL);
}

PointCloud cloud;

public void setup(){

    // Papart papart = new Papart(this);
    // Camera cameraTracking = CameraFactory.createCamera(papart.cameraConfig.getCameraType(),
    //                                                    papart.cameraConfig.getCameraName());
    // cameraTracking.setParent(this);
    // cameraTracking.setCalibration(papart.cameraCalib);
    // ProjectorDisplay projector = new ProjectorDisplay(this, papart.projectorCalib);
    // PMatrix3D extrinsics = papart.loadCalibration(papart.cameraProjExtrinsics);
    // projector.setExtrinsics(extrinsics);


    Papart papart = Papart.projection(this);
    ProjectorDisplay projector = (ProjectorDisplay) papart.getDisplay();
    projector.manualMode();

    Camera cameraTracking = papart.getCameraTracking();
    // start enables to load calibration from inside the device...
    cameraTracking.start();
    
    DecodedCode decodedCode = DecodedCode.loadFrom(this, "../grayCodeConfiguration/scan0");

    Scanner3D scanner = new Scanner3D(cameraTracking.getProjectiveDevice(), projector);

//    scanner.compute3DPos(decodedCode, 2, 4, 4);
    scanner.compute3DPosUniqueProj(decodedCode, 1, 4, 4);
    cloud = scanner.asPointCloud(this);

    scanner.savePoints(this, "points.obj");
    println("OK");

    // Set the virtual camera
    cam = new PeasyCam(this, 0, 0, 1200, 500);
    cam.setMinimumDistance(50);
    cam.setMaximumDistance(1200);
    cam.setActive(true);

    // exit();
}

void draw(){
    background(100);
    cloud.drawSelf((PGraphicsOpenGL) g);
}
