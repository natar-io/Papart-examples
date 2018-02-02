import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import org.openni.*;
import tech.lity.rea.skatolo.Skatolo;

float renderQuality = 1.5f;
Papart papart;

// String calibrationFileName = "A4-calib.svg";
String calibrationFileName = "A4-default.svg";
//String calibrationFileName = "ExtractedView.bmp";

void settings(){
    fullScreen(P3D);
}

 void setup(){
     Papart.calibrationFileName = calibrationFileName;
     papart = Papart.projection(this);
     papart.loadSketches();
     papart.startTracking();
}

void draw(){
}

void keyPressed() {
}
