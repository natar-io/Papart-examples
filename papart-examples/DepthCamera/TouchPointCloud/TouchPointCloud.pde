import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.skatolo.Skatolo;

Papart papart;

void settings(){
    size(640, 480, P3D);
}

public void setup() {
    papart = new Papart(this);
    papart.initKinectCamera(1);
    papart.loadTouchInputKinectOnly();
    papart.loadSketches();
    papart.startTracking();
}

void draw() {
}
