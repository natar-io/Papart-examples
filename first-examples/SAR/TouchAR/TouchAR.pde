import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.skatolo.Skatolo;
import org.openni.*;

import redis.clients.jedis.*;

Papart papart;
TouchDetectionDepth fingerDetection;

void settings(){
    fullScreen(P3D);
}
 void setup(){
     papart = Papart.projection(this);
     fingerDetection = papart.loadTouchInput().initHandDetection();
     //     papart.loadTouchInput().initSimpleTouchDetection();
     new MyApp();
     papart.startTracking();
}


void draw(){
}

boolean test = false;

void keyPressed() {
    if(key == 't')
	test = !test;
}
