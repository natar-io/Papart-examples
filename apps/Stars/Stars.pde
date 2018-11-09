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
import tech.lity.rea.skatolo.Skatolo;
import org.openni.*;

Papart papart;
TouchDetectionDepth fingerDetection;

void settings(){
    fullScreen(P3D);
}


void setup(){
     papart = Papart.projection(this);
     fingerDetection = papart.loadTouchInput().initHandDetection();
     new MyApp();
     papart.startTracking();
     frameRate(30);
}

void draw(){
}
