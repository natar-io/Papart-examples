import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;

Papart papart;

void settings() {
  fullScreen(P3D);
}

<<<<<<< HEAD
void setup() {

  if (useProjector) {
    papart = Papart.projection(this);
    papart.loadTouchInput();
  } else {

    try {
      papart = new Papart(this);
      papart.initKinectCamera(renderQuality);
      papart.loadTouchInputKinectOnly();
    } 
    catch(Exception e) {
      println("Exception " + e);
      e.printStackTrace();
    }
  }

  papart.loadSketches();
  papart.startTracking();
}


void draw() {
=======
void setup(){
    papart = new Papart(this);
    papart.initKinectCamera(1);
    papart.loadTouchInputKinectOnly();
    papart.loadSketches();
    papart.startTracking();
}

void draw(){
>>>>>>> 04daeec55a745c083c145f6c5ea487c9c928e065
}

boolean test = false;

void keyPressed() {
  if (key == 't')
    test = !test;
}