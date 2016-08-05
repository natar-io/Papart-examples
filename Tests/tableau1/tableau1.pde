import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.skatolo.Skatolo;


import fr.inria.papart.calibration.PlaneAndProjectionCalibration;
import fr.inria.papart.calibration.PlaneCalibration;
import fr.inria.papart.calibration.ScreenConfiguration;
import fr.inria.papart.calibration.CameraConfiguration;
import fr.inria.papart.procam.camera.*;

float renderQuality = 1.5f;
Papart papart;

void settings() {
  fullScreen(P3D);
}

void setup() {
  Papart.calibrationFileName = "mega-calib.svg";
  //papart = Papart.projeaction(this);
  //papart.loadSketches();
  //papart.startTracking();


  ScreenConfiguration screenConfiguration = Papart.getDefaultScreenConfiguration(this);
  CameraConfiguration cameraConfiguration = Papart.getDefaultCameraConfiguration(this);


  //Papart.removeFrameBorder(this);
  float quality = 1f;
  Papart papart = new Papart(this);

  //papart.initProjectorDisplay(quality);
  //papart.tryLoadExtrinsics();
  ProjectorDisplay   projector = new ProjectorDisplay(this, Papart.projectorCalib);
  projector.setZNearFar(10, 12000);
  projector.setQuality(quality);

  projector.init();
  
  Camera cameraTracking = cameraConfiguration.createCamera();
  cameraTracking.setParent(this);
  cameraTracking.setCalibration(Papart.cameraCalib);
  //cameraTracking.start();

  // loadTracking(Papart.cameraCalib);
        Camera.convertARParams(this, Papart.cameraCalib, Papart.camCalibARtoolkit);
        cameraTracking.initMarkerDetection(Papart.camCalibARtoolkit);

  cameraTracking.setThread();
  projector.setCamera(cameraTracking);
  
  new MyApp(cameraTracking, projector);
}

void draw() {
  
}

void keyPressed() {
  if (key == 'c')
    papart.calibration();
  if (key == 'l') 
    app.loadLocationFrom("marker.xml");

  if (key == 'm')
    app.useManualLocation(false);

  if (key == 'f')
    app.useManualLocation(true);
}