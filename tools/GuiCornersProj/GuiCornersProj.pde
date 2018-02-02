import tech.lity.rea.skatolo.*;  //<>//
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.guimodes.Mode;
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.utils.*;
import org.bytedeco.javacpp.*;
import toxi.geom.*;
import fr.inria.papart.calibration.*;

Papart papart;
ARDisplay projectorDisplay;
// Camera camera;

//GUI elements
Skatolo skatolo;
tech.lity.rea.skatolo.gui.group.Textarea titre;
Textfield inputWidth;
Textfield inputHeight;
tech.lity.rea.skatolo.gui.controllers.Button buttonChangeSize;
tech.lity.rea.skatolo.gui.controllers.Button buttonOppositeX;
tech.lity.rea.skatolo.gui.controllers.Button buttonOppositeY;
tech.lity.rea.skatolo.gui.controllers.Button saveButton;
Textlabel xAxis;
Textlabel yAxis;
Textlabel zero;
Textlabel labelX;
Textlabel labelY;

float objectWidth = 500;
float objectHeight = 375;

float rectAroundWidth = 20;


PMatrix3D paperCameraTransform, pos;
PVector object[];
PVector image[];

void settings() {
    size(1280, 720, P3D);
}

// TODO:
// - replace the handles with the Skatolo handle.
// - some refactoring/renaming

public void setup() {

  Papart.projectionOnly(this);

  papart =  Papart.getPapart();
  projectorDisplay = papart.getProjectorDisplay();
  projectorDisplay.manualMode();
  PMatrix3D identity = new PMatrix3D(1, 0, 0, 0,
				     0, 1, 0, 0,
				     0, 0, 1, 0,
				     0, 0, 0, 1);
  projectorDisplay.setExtrinsics(identity);
				     
  // papart.startCameraThread();
  // camera = papart.getCameraTracking();


  object = new PVector[4];
  image = new PVector[4];

  // 10 cm.
  object[0] = new PVector(0, 0, 0);
  object[1] = new PVector(objectWidth, 0, 0);
  object[2] = new PVector(objectWidth, objectHeight, 0);
  object[3] = new PVector(0, objectHeight, 0);

  image[0] = new PVector(250, 250);
  image[1] = new PVector(350, 250);
  image[2] = new PVector(350, 350);
  image[3] = new PVector(250, 350);

  skatolo = new Skatolo(this, this);
  skatolo.setAutoDraw(false);

  initGui();
  
  Mode.add("corners");
  Mode.add("changeSize");
  
  setModeCorners();
  // setModeChangeSize();
}

void initGui(){
  titre = skatolo.addTextarea("titre")
    .setPosition(270, 30);

  inputHeight = skatolo.addTextfield("height")
    .setVisible(true)
    .setPosition(20, 20)
    .setSize(40, 10)
    ;

  inputWidth = skatolo.addTextfield("width")
    .setVisible(true)
    .setPosition(70, 20)
    .setSize(40, 10)
    ;

  buttonChangeSize = skatolo.addButton("confirm")
    .setPosition(20, 50)
    .setSize(90, 30)
    .setLabel("change mode");

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

  xAxis = skatolo.addTextlabel("x").setText("X");
  yAxis = skatolo.addTextlabel("y").setText("Y");

  labelX = skatolo.addTextlabel("maxXValue");
  labelY = skatolo.addTextlabel("maxYValue");
  zero = skatolo.addTextlabel("zero").setText("0,0");


}


public void draw() {

    computeTransformation();
    
    background(0);

    PGraphicsOpenGL graphics = projectorDisplay.beginDraw();
    graphics.clear();
    graphics.fill(200, 200, 100);
    graphics.modelview.apply(paperCameraTransform);
    graphics.rect(0, 0, 500, 375);

    projectorDisplay.endDraw();
    DrawUtils.drawImage((PGraphicsOpenGL) g, 
			projectorDisplay.render(), 
			0, 0, width, height);
    
    // if (Mode.is("changeSize"))
    //   drawChangeSize();   
    // else if (Mode.is("corners"))
    drawCorners(graphics);
    skatolo.draw();
}



void computeTransformation(){
  ProjectiveDeviceP pdp = projectorDisplay.getProjectiveDeviceP();
  paperCameraTransform = pdp.estimateOrientation(object, image);
}

// when the 3D position is saved
// draw a blue rectangle around the current selection
public void drawRects(PGraphicsOpenGL graphics) {
  graphics.fill(50, 50, 200, 200);
  graphics.rect(-rectAroundWidth, 
    -rectAroundWidth, 
    objectWidth + rectAroundWidth*2, 
    objectHeight + rectAroundWidth*2);
}
