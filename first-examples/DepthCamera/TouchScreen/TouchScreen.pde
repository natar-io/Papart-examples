import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import fr.inria.papart.multitouch.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.openni.*;

void settings(){
    size(640, 480, P3D);
}

void setup(){
    Papart papart = Papart.seeThrough(this);
    papart.loadTouchInput();
    papart.loadSketches() ;
    papart.startTracking();
}


void draw(){
}
