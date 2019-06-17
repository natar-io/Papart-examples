import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

Papart papart;
TouchDetectionDepth fingerDetection;
TouchVisualization tVisualization;

void settings() {
  size(640, 480, P3D);
}

public void setup() {
  papart = Papart.seeThrough(this);
  fingerDetection = papart.loadTouchInput().initHandDetection();
  tVisualization = new TouchVisualization();
  papart.startTracking();
}

void draw() {}
