import toxi.volume.*;

// PapARt library
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import java.awt.Color;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import org.openni.*;

Papart papart;
Skatolo skatolo;
void settings() {
    size(640, 480, P3D);
}



float threshGlobal = 0; // 40  ~ not used.
float threshHue = 0;    // 40
float threshSat = 0;    // 50 
float threshIntens = 0; // 90
float redThresh = 0;  // 30
float blueThresh = 0;  // 30

int erosionAmount = 1;

// TODO: replace with a list. 
String currentColor = "red";

void setup() {
  papart = Papart.seeThrough(this);
  papart.loadSketches() ;
  papart.startTracking() ;

  // Create the Graphical interface
  skatolo = new Skatolo(this);

  skatolo.addSlider("erosionAmount")
      .setPosition(100,0)
      .setSize(100, 5)
      .setRange(0,10)
      ;

  skatolo.addSlider("threshHue")
      .setPosition(100,50)
      .setSize(255, 5)
      .setValue(40)
      .setRange(0,255)
      ;
  
  skatolo.addSlider("threshSat")
      .setPosition(100,80)
      .setSize(255, 5)
      .setValue(50)
      .setRange(0,255)
      ;
  
  skatolo.addSlider("threshIntens")
      .setPosition(100,110)
      .setSize(255, 5)
      .setValue(90)
      .setRange(0,255)
      ;
  
  skatolo.addSlider("redThresh")
      .setPosition(100,170)
      .setSize(255, 5)
      .setValue(30)
      .setRange(0,255)
      ;

  skatolo.addSlider("blueThresh")
      .setPosition(100,200)
      .setSize(255, 5)
      .setValue(30)
      .setRange(0,255)
      ;

}

void keyPressed(){
    if(key == 's'){
	saveColorAndThresholds();
    }
    if(key == 'l'){
	loadColorAndThresholds();
    }

    if(key == 'r'){
	println("Configuration of Red tracking color");
	currentColor = "red";
    }
    if(key == 'b'){
	println("Configuration of Blue tracking color");
	currentColor = "blue";
    }

   if(key == 'x'){
	println("Configuration of blink color");
	currentColor = "x";
    }
    
}


String saveFile = Papart.redThresholds; //"data/thresholds.txt";

void saveColorAndThresholds(){

    String words = "hue:"+  Float.toString(threshHue) +  " " +
	"sat:"+  Float.toString(threshSat) + " "+
	"intens:"+  Float.toString(threshIntens) + " "+
	"erosion:"+  Integer.toString(erosionAmount) + " ";
	//	"red:"+  Float.toString(redThresh) + " "+
	//	"blue:"+  Float.toString(blueThresh) + " "+
	//	"col:"+  Integer.toString(redColor);
    
    if(currentColor.equals("red")){
	saveFile = Papart.redThresholds;
	words = words + "red:"+  Float.toString(redThresh) + " ";
	words = words + "col:"+  Integer.toString(redColor);
    }
    if(currentColor.equals("blue")){
	saveFile = Papart.blueThresholds;
	words = words + "blue:"+  Float.toString(blueThresh)+ " ";
	words = words + "col:"+  Integer.toString(blueColor);
    }
    
    String[] list = split(words, ' ');
    saveStrings(saveFile, list);
}

void loadColorAndThresholds(){

    if(currentColor.equals("red")){
	saveFile = Papart.redThresholds;
    }
    if(currentColor.equals("blue")){
	saveFile = Papart.blueThresholds;
    }

    String[] list = loadStrings(saveFile);
    for(int i = 0; i < list.length; i++){
	String data = list[i];
	loadParameter(data);
    }
}

void loadParameter(String data){
    String[] pair = data.split(":");
    if(pair[0].startsWith("hue")){
	threshHue = Float.parseFloat(pair[1]);
	skatolo.get("threshHue").setValue(threshHue);
    }
    if(pair[0].startsWith("sat")){
	threshSat = Float.parseFloat(pair[1]);
	skatolo.get("threshSat").setValue(threshSat);
    }
    if(pair[0].startsWith("intens")){
	threshIntens = Float.parseFloat(pair[1]);
	skatolo.get("threshIntens").setValue(threshIntens);
    }
    if(pair[0].startsWith("red")){
	redThresh = Float.parseFloat(pair[1]);
	skatolo.get("redThresh").setValue(redThresh);
    }

    if(pair[0].startsWith("blue")){
	blueThresh = Float.parseFloat(pair[1]);
	skatolo.get("blueThresh").setValue(blueThresh);
    }

    if(pair[0].startsWith("erosion")){
	erosionAmount = Integer.parseInt(pair[1]);
	skatolo.get("erosionAmount").setValue(erosionAmount);
    }
    if(pair[0].startsWith("col")){
	// not sure...
	if(currentColor.equals("red")){
	    redColor = Integer.parseInt(pair[1]);	
	}
	if(currentColor.equals("blue")){
	    blueColor = Integer.parseInt(pair[1]);	
	}
    }
}


void draw() {
  
    // Draw the GUI
    hint(ENABLE_DEPTH_TEST);
    skatolo.draw();
    hint(DISABLE_DEPTH_TEST);
}
