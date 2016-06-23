// PapARt library
import fr.inria.papart.procam.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;

import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.display.*;

import fr.inria.skatolo.*;
import fr.inria.skatolo.events.*;
import fr.inria.skatolo.gui.controllers.*;
import fr.inria.skatolo.gui.widgets.*;

TrackedView boardView;
Papart papart;
ARDisplay cameraDisplay;
Camera camera;

Skatolo skatolo;
PixelSelect origin, xAxis, yAxis, corner;
fr.inria.skatolo.gui.controllers.Button saveButton;
PVector[] corners = new PVector[4];

int outputImageWidth = 640;
int outputImageHeight = 320;

public void settings(){
    size(200, 200, P3D);
}

public void setup(){
    Papart papart = Papart.seeThrough(this);


    papart =  Papart.getPapart();
    cameraDisplay = papart.getARDisplay();
    cameraDisplay.manualMode();

    camera = papart.getCameraTracking();

    boardView = new TrackedView();
    //    boardView.setCaptureSizeMM(new PVector(1280, 800));
    boardView.setImageWidthPx(outputImageWidth);
    boardView.setImageHeightPx(outputImageHeight);
    boardView.init();

    corners[0] = new PVector(100, 100);
    corners[1] = new PVector(200, 100);
    corners[2] = new PVector(200, 200);
    corners[3] = new PVector(100, 200);

    // cursor(CROSS);

    skatolo = new Skatolo(this, this);

    saveButton = skatolo.addButton("saveButton")
        .setColorBackground(color(7, 189, 255))
        .setPosition(20, 420)
        .setSize(90, 30);


    origin = skatolo.addPixelSelect("origin")
        .setPosition(100,100)
        .setLabel("(0, 0)")
        ;

    xAxis = skatolo.addPixelSelect("xAxis")
        .setLabel("(x, 0)")
        .setPosition(150,100)
        ;

    corner = skatolo.addPixelSelect("corner")
        .setLabel("(x, y)")
        .setPosition(150,150)
        ;

    yAxis = skatolo.addPixelSelect("yAxis")
        .setLabel("(0, y)")
        .setPosition(100,150)
        ;


}

void draw(){

  PImage img = camera.getImage();
    if(img == null)
	return;

    background(0);
    image(img, 0, 0, width, height);


  if(view != null){
      image(view, 0, 0, 100, 100);
  }

}

boolean test = false;
int currentPt=0;

void mouseDragged() {
  corners[currentPt] = new PVector(mouseX, mouseY);
}

PImage view = null;

void updateCorners(){
    corners[0].set(getPositionOf(origin));
    corners[1].set(getPositionOf(xAxis));
    corners[2].set(getPositionOf(corner));
    corners[3].set(getPositionOf(yAxis));
}

PVector getPositionOf(PixelSelect widget){
    float[] pos = widget.getArrayValue();
    return new PVector(pos[0], pos[1]);
}

void keyPressed() {

  if (key == '1')
    currentPt = 0;

  if (key == '2')
    currentPt = 1;

  if (key == '3')
    currentPt = 2;

  if (key == '4')
    currentPt = 3;

  if (key == 't')
    test = !test;

  if (key == 's') {
      save();
  }
}

void saveButton(){
    save();
}

void save(){
    updateCorners();
    boardView.setCorners(corners);
    view = boardView.getViewOf(camera);
    view.save(sketchPath("ExtractedView.bmp"));
    println("Saved");
}
