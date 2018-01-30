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
boolean useProjection = false;


void settings(){
    if(useProjection){
	fullScreen(P3D);
    }else  {
	size(640, 480, P3D);
    }
}

 void setup(){
     if(useProjection){
	 papart = Papart.projection(this);
     }else{
     papart = Papart.seeThrough(this);
     }
     
     papart.loadTouchInput();
     //      papart.loadSketches();
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
        papart.multiCalibration();

    // TEST
    // save the touch calibration 
    if(key == 's'){
	papart.multiCalibrator.toSave = true;	
    }
    // if(key == 'e'){
    // 	papart.multiCalibrator.evaluateMode = !papart.multiCalibrator.evaluateMode;
    // }

    // if(key == 's')
    // 	papart.setTableLoca(tion(app);
    
}
