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

import fr.inria.guimodes.Mode;

import org.openni.*; 

boolean useDebug = false;
boolean useCam = false;

void settings(){
    fullScreen(P3D);
    // size(640,480, P3D);
}
     Papart papart;

 void setup(){

     if(useDebug){
	 papart = new Papart(this);
	 papart.initDebug();
	 //	 papart.loadTouchInputTUIO();
     } else {

	 if(useCam){
	     papart = Papart.seeThrough(this, 1.0f);
	 } else {
	     papart = Papart.projection(this, 1.0f);
	     // papart.loadTouchInput().initHandDetection();
	     papart.loadTouchInput().initSimpleTouchDetection();
	 }

	 // papart.loadTouchInput();
     }
     Mode.add("add");
     Mode.add("subtract");
     Mode.add("normal");

     colorMode(RGB, 255);

     //  /!/ BlueApp does nothing but enables the marker tracking!
     new BlueApp();
     new ModesZone();
     new Plateau();
     new InfoReader();
     new InfoShow();
     
     // new ColorApp("vert.svg", 150, 150, color(0, 255, 0));
     // new ColorApp("rouge.svg", 100, 100, color(255, 0, 0));
     // new ColorApp("cyan.svg", 150, 200, color(0, 255, 255));
     // new ColorApp("jaune.svg", 250, 200, color(255, 255, 0));
     // new ColorApp("magenta.svg", 250, 200, color(255, 0, 255));     
     

     frameRate(60);
     papart.startTracking();
 }


void draw(){

}

boolean additive = true;

void keyPressed() {
    if(key == 'a')
	Mode.set("add");

    if(key == 's')
	Mode.set("subtract");

    if(key == 'n')
	Mode.set("normal");
}
