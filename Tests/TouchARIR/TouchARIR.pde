import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.skatolo.Skatolo;

float renderQuality = 1.5f;
Papart papart;

void settings(){
    fullScreen(P3D);
}

 void setup(){
     //     papart = Papart.seeThrough(this);
     papart = Papart.projection(this);
     papart.loadIRTouchInput();
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
