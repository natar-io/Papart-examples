// Natar
import tech.lity.rea.nectar.camera.*;
// import tech.lity.rea.javacvprocessing.*;

// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.opencv_core;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

import tech.lity.rea.nectar.tracking.MarkerBoardFactory;
// GUI
import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

Papart papart;
ARDisplay display;
Camera camera;

Skatolo skatolo;

PaperContent paperContent;

int paperBackgroundColor = 0;

void settings() {
  size(640, 480, P3D);
}

VideoEmitter emitter;

void setup() {
  // application only using a camera
  // screen rendering
    try{
  papart = Papart.seeThrough(this);
  
  // Get the AR rendering display.
  display = papart.getARDisplay();
  // Do not draw automatically.
  display.manualMode();
  
  camera = display.getCamera();
  
  paperContent = new PaperContent();
  
  //  frameRate(2);
  //  papart.setDistantCamera("10.42.0.169", 6379);
  //  papart.setDistantCamera("192.168.2.1", 6379);

  // Method #1 Stream the AR PART
  //  papart.streamOutput("192.168.2.1", 6379, "", "display0");

  // Method #2 Stream custom image
  // emitter = new VideoEmitter("192.168.2.1", 6379, "", "display0");
  MarkerBoardFactory.USE_JSON = false;
    
  papart.startTracking();

  // Create the Graphical interface
  skatolo = new Skatolo(this);
  skatolo.addButton("onTBoxClick")
            .setPosition(20, 20)
            .setSize(150, 20)
            .setCaptionLabel("Change paper background");

    }catch(Exception e){
	e.printStackTrace();
    }
}

void onTBoxClick() {
  paperBackgroundColor += 1;
  if (paperBackgroundColor == 10) {
    paperBackgroundColor = 0;
  }
}

void draw() {
  // Ask the Display to be rendered offscreen.
  // Nothing is drawn directly here.
  display.drawScreens();

  noStroke();
  // draw the camera image
  if (camera != null && camera.getPImage() != null) {
       image(camera.getPImage(), 0, 0, width, height);
  }

  // draw the AR
  display.drawImage((PGraphicsOpenGL) g, display.render(), 0, 0, width, height);

  
  // Draw the GUI
  hint(ENABLE_DEPTH_TEST);
  skatolo.draw();
  hint(DISABLE_DEPTH_TEST);

  // Method #1  (necessary only when draw() is overridden)
  // display.tryToEmitVideo();

  // Method #2
  // emitter.sendImage((PImage) this.g, millis());
}
