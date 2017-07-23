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

Papart papart;
Skatolo skatolo;

void settings() {
    size(640, 480, P3D);
}

float threshGlobal = 0;
float threshHue = 0;
float threshSat = 0;
float threshIntens = 0;
float redThresh = 0;

int erosionAmount = 1;

void setup() {
  papart = Papart.seeThrough(this);
  papart.loadSketches() ;
  papart.startTracking() ;

  // Create the Graphical interface
  skatolo = new Skatolo(this);

  skatolo.addSlider("erosionAmount")
      .setPosition(100,0)
      .setSize(100, 20)
      .setRange(0,10)
      ;

  skatolo.addSlider("threshHue")
      .setPosition(100,50)
      .setSize(255, 20)
      .setValue(40)
      .setRange(0,255)
      ;
  
  skatolo.addSlider("threshSat")
      .setPosition(100,80)
      .setSize(255, 20)
      .setValue(50)
      .setRange(0,255)
      ;
  
  skatolo.addSlider("threshIntens")
      .setPosition(100,110)
      .setSize(255, 20)
      .setValue(90)
      .setRange(0,255)
      ;
  
  skatolo.addSlider("redThresh")
      .setPosition(100,170)
      .setSize(255, 20)
      .setValue(30)
      .setRange(0,255)
      ;
}

void draw() {
  
    // Draw the GUI
    hint(ENABLE_DEPTH_TEST);
    skatolo.draw();
    hint(DISABLE_DEPTH_TEST);
}