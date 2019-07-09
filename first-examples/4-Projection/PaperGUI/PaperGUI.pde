// PapARt library
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.openni.*;

Papart papart;
TouchDetectionDepth fingerDetection;
PaperScreen paperContent;

void settings(){
  fullScreen(P3D);
}

public void setup() {
  papart = Papart.projection(this);
  fingerDetection = papart.loadTouchInput().initHandDetection();

  // papart.setDistantCamera("192.168.2.1", 6379);
  paperContent = new PaperContent();
   papart.startTracking();
}

 void draw() {}
