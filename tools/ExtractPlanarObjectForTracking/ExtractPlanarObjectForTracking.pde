import tech.lity.rea.skatolo.*;  //<>//
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.guimodes.Mode;
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.utils.DrawUtils;
import org.bytedeco.javacpp.*;
import toxi.geom.*;
import fr.inria.papart.calibration.*;

import org.openni.*;

Papart papart;
ARDisplay cameraDisplay;
Camera camera;

//GUI elements
Skatolo skatolo;
tech.lity.rea.skatolo.gui.group.Textarea titre;
tech.lity.rea.skatolo.gui.controllers.Button buttonOppositeX;
tech.lity.rea.skatolo.gui.controllers.Button buttonOppositeY;
tech.lity.rea.skatolo.gui.controllers.Button saveButton;
Textlabel zero;
Textlabel labelX;
Textlabel labelY;

float rectAroundWidth = 20;

PMatrix3D pos;
PVector image[];

TrackedView boardView;

int outputImageWidth = 640;
int outputImageHeight = 640;

PImage view = null;

void settings() {
  size(640, 480, P3D);
}

public void setup() {

    papart = Papart.seeThrough(this);
    cameraDisplay = papart.getARDisplay();
    cameraDisplay.manualMode();

    camera = papart.getCameraTracking();
    camera.start();
    camera.setThread();
    
  image = new PVector[4];

  image[0] = new PVector(250, 250);
  image[1] = new PVector(350, 250);
  image[2] = new PVector(350, 350);
  image[3] = new PVector(250, 350);

  boardView = new TrackedView();
  boardView.setImageWidthPx(outputImageWidth);
  boardView.setImageHeightPx(outputImageHeight);
  boardView.init();

  skatolo = new Skatolo(this, this);

  skatolo.setAutoDraw(false);

  titre = skatolo.addTextarea("titre")
    .setPosition(270, 30);

  buttonOppositeX = skatolo.addButton("oppositeX")
    .setColorBackground(color(255, 142, 2))
    .setColorActive(color(224, 125, 18))
    .setPosition(20, 140)
    .setSize(90, 30)
    .setLabel("change X Axis");

  buttonOppositeY = skatolo.addButton("oppositeY")
    .setColorBackground(color(7, 189, 255))
    .setPosition(20, 180)
    .setSize(90, 30)
    .setLabel("change Y Axis");

  saveButton = skatolo.addButton("save")
    .setColorBackground(color(7, 189, 255))
    .setPosition(20, 420)
    .setSize(90, 30);

  labelX = skatolo.addTextlabel("maxXValue");
  labelY = skatolo.addTextlabel("maxYValue");
  zero = skatolo.addTextlabel("zero").setText("0,0");

  Mode.add("corners");
  setModeCorners();
}

public void draw() {

  PGraphicsOpenGL graphics = initDraw();

  if (Mode.is("corners"))    
    drawCorners(graphics);    

  skatolo.draw();
}
