import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import processing.video.*;
import org.openni.*;

import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.skatolo.Skatolo;

float renderQuality = 1.5f;
Papart papart;
boolean useProjector = false;

void settings(){
    if(useProjector)
	fullScreen(P3D);
    else
	size(640, 480, P3D);
}

 void setup(){
     if(useProjector)
	 papart = Papart.projection(this);
     else
	 papart = Papart.seeThrough(this);
     papart.loadTouchInput();
     papart.loadSketches();
     papart.startTracking();
}


void draw(){
    background(10);
}

boolean test = false;

void keyPressed() {
    if(key == 't')
	test = !test;

    // if(key == 'c')
    //     papart.calibration();

}
