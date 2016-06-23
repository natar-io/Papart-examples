import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;

Papart papart;

void settings(){
    size(200, 200, P3D);
}

void setup(){
    papart = new Papart(this);
    papart.initKinectCamera(1);
    papart.loadTouchInputKinectOnly();
    papart.loadSketches();
    papart.startTracking();
}

void draw(){
}

boolean test = false;

void keyPressed() {
    if(key == 't')
	test = !test;
}
