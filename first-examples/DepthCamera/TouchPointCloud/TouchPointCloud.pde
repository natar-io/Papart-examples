import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

Papart papart;

void settings(){
    size(640, 480, P3D);
}

public void setup() {
    papart = Papart.seeThrough(this);
    papart.loadTouchInput();
    papart.loadSketches();
    papart.startTracking();
}

void draw() {
}
