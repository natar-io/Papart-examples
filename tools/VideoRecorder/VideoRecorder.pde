// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.opencv_core;
import org.reflections.*;
import toxi.geom.*;
import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import org.openni.*;

Papart papart;
Skatolo skatolo;

ARDisplay display;
Camera camera;
Button recordButton;


// ffmpeg -start_number 294 -i image-%3d.png out.mkv -vcodec libx264 -crf 0 -b 50M

// ffmpeg -start_number 294 -e multifilesrc location image-%3d.png out.mkv -vcodec libx264 -crf 0 -b 50M


void settings() {
    size(200, 200, P3D);
}


boolean isRecording = false;

void setup() {
  // application only using a camera
  // screen rendering
  papart = Papart.seeThrough(this);
  papart.loadSketches();
  papart.startTracking();

  // Get the AR rendering display.
  display = papart.getARDisplay();
  // Do not draw automatically.
  display.manualMode();

  camera = display.getCamera();

  // Create the Graphical interface
  skatolo = new Skatolo(this);
  recordButton = skatolo.addButton("record",1,20,20,100,20);
  recordButton.setLabel("start recording");
}

int backgroundColor = 0;

void record(){
    if(isRecording){
        stopRecording();
    } else {
        startRecording();
    }
}


void startRecording(){
    recordButton.setLabel("stop recording");
    isRecording = true;
}

void stopRecording(){
    recordButton.setLabel("start recording");
    isRecording = false;
}


int imageID = 0;


void draw() {

    // Ask the Display to be rendered offscreen.
    // Nothing is drawn here.
    display.drawScreensOver();

    noStroke();

    // draw the camera image
    if (camera != null && camera.getPImage() != null) {
        image(camera.getPImage(), 0, 0, width, height);
    }

    //    camera.getPImage().save();

    if(isRecording){
        // Linux only -- Save to RAM
        saveFrame("/dev/shm/image-###.png");

        // Save to Disk
        // saveFrame("image-###.png");
    }

    // draw the AR
    display.drawImage((PGraphicsOpenGL) g, display.render(),
                      0, 0, width, height);

    // Draw the GUI
    hint(ENABLE_DEPTH_TEST);
    skatolo.draw();
    hint(DISABLE_DEPTH_TEST);
}
