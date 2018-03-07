import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import tech.lity.rea.colorconverter.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

Papart papart;

void settings(){
    fullScreen(P3D);
}

public void setup() {
    papart = Papart.projection(this);
    //    papart = Papart.seeThrough(this);
    papart.loadTouchInput().initHandDetection();
    papart.loadSketches();
    papart.startTracking();
}

void draw() {
}
