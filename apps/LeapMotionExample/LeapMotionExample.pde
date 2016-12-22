// PapARt library
import fr.inria.papart.procam.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;

void settings(){
    size(200, 200, P3D);
}

LeapMotion leap;

void setup(){
    Papart papart = Papart.seeThrough(this);

    leap = new LeapMotion(this);

    papart.loadSketches() ;
    papart.startTracking() ;
}

void draw(){
}
