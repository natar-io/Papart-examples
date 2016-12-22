import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import fr.inria.skatolo.Skatolo;

Papart papart;

public void settings(){
    fullScreen(P3D);
}


public void setup() {
    papart = Papart.projection(this);
    papart.loadTouchInput();

    papart.loadSketches();
    papart.startTracking();
}

void draw() {
}
