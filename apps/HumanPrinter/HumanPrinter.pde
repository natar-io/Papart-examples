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
import org.openni.*;

float renderQuality = 1.5f;
Papart papart;

void settings(){
    //    fullScreen(P3D);
    size(640, 480, P3D);
}

 void setup(){
     //      papart = Papart.projection(this);
     papart = Papart.seeThrough(this);
     papart.loadTouchInput();
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
