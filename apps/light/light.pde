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
boolean useCam = true;

void settings(){
   //    fullScreen(P3D);
     size(640,480, P3D);
}

 void setup(){

     Papart papart;
     
     if(useDebug){
	 papart = new Papart(this);
	 papart.initDebug();
	 papart.loadTouchInputTUIO();
     } else {

	 if(useCam){
	     papart = Papart.seeThrough(this, 1.0f);
	 } else {
	     papart = Papart.projection(this, 1.0f);
	 }

	 // papart.loadTouchInput();
     }
     Mode.add("add");
     Mode.add("subtract");
     Mode.add("normal");

     colorMode(RGB, 255);

     // fist to draw.
     new BlueApp();

     new ColorApp("vert.svg", 150, 150, color(0, 255, 0));
     new ColorApp("rouge.svg", 100, 100, color(255, 0, 0));

     new ColorApp("cyan.svg", 150, 200, color(0, 255, 255));
     new ColorApp("jaune.svg", 250, 200, color(255, 255, 0));
     new ColorApp("magenta.svg", 250, 200, color(255, 0, 255));     
     
     new AddApp();
     new SubApp();
     

     frameRate(60);
     papart.startTracking();
 }


void draw(){
    checkMode();
}

void checkMode(){
    if(addSeen){
	Mode.set("add");
	//	println("Switch to ADD mode");
	if(subSeen){
	    Mode.set("normal");
	    println("Switch to NORMAL (both) mode");
	}
    } else {
	if(subSeen){
	    Mode.set("subtract");
	    // println("Switch to SUB mode");
	} else {
	    Mode.set("normal");
	    //	    println("Switch to NORMAL (none) mode");
	}
    }


}


boolean additive = true;

void keyPressed() {
    if(key == 'a')
	Mode.set("add");

    if(key == 's')
	Mode.set("subtract");

    if(key == 'n')
	Mode.set("normal");

    if(key == 's')
	saveLocation = true;
}