import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.skatolo.Skatolo;

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
