// PapARt library
import fr.inria.papart.procam.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;

Papart papart;

void settings(){
    size(640, 480, P3D);
}

public void setup() {
    Papart papart = Papart.seeThrough(this);
    papart.loadTouchInputKinectOnly();

    papart.loadSketches();
    papart.startTracking();
}

void draw() {
}
