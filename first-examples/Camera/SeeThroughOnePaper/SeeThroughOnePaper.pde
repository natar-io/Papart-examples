// PapARt library
import fr.inria.papart.procam.*;

// Library dependencies
import tech.lity.rea.svgextended.*;
import org.reflections.*;
import toxi.geom.*;
import org.bytedeco.javacv.*;

// OpenNI for Orbbec cameras. 
import org.openni.*;
// Processing video for webcams
import processing.video.*;

Papart papart;

public void setup() {
  // application only using a camera
  // screen rendering
  papart = Papart.seeThrough(this);
  papart.loadSketches();
  papart.startTracking();
}

void settings() {
  // the application will be rendered in full screen, and using a 3Dengine.
    size(640, 480, P3D);
}

void draw() {
}
