import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

Papart papart;
TouchDetectionDepth fingerDetection;

void settings(){
    size(640, 480, P3D);
}

public void setup() {
    papart = Papart.seeThrough(this);
    fingerDetection = papart.loadTouchInput().initHandDetection();
    new MyApp();
    papart.startTracking();
}

void draw() {
}
