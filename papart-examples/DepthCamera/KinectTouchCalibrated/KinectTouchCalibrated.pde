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
    try{
    papart.initKinectCamera(1);
    papart.loadTouchInputKinectOnly();

    }catch(Exception e){
        println("e " + e);
        e.printStackTrace();
    }
   papart.loadSketches();
    papart.startTracking();
}

void draw() {
}
