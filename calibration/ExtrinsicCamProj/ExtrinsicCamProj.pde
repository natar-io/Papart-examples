import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;

import org.openni.*;

import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.skatolo.Skatolo;

float renderQuality = 1.0f;
Papart papart;

void settings(){
    fullScreen(P3D);
}

 void setup(){
     papart = Papart.projection(this);
     papart.loadTouchInput();
     papart.loadSketches();
     papart.startTracking();
}


void draw(){
    //    println("Framerate: "  + frameRate);
}

boolean test = false;

void keyPressed() {
    if(key == 't')
	test = !test;

    if(key == 'c')
        papart.calibration(app, calibrator);

    if(key == 's')
	papart.setTableLocation(app);
    
}
