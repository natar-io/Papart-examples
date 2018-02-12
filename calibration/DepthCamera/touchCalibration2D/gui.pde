Slider recursionSlider, searchDepthSlider;
Slider maxDistanceSlider, maxDistanceInitSlider, minCompoSizeSlider;
Slider normalSlider;


Slider minHeightSlider;
Slider forgetTimeSlider;
Slider trackingMaxDistanceSlider;
Slider precisionSlider;
Slider planeHeightSlider;
Slider planeUpAmountSlider;

Button switchTo3DButton;

RadioButton depthAnalysisRadio;
RadioButton depthVisuRadio;


void initGui(){

    skatolo = new Skatolo(this);

    recursionSlider = skatolo.addSlider("recursion")
	.setPosition(30, 50)
	.setRange(1, 50)
	.setSize(300, 12);

    searchDepthSlider = skatolo.addSlider("searchDepth")
	.setPosition(30, 70)
	.setRange(1, 50)
	.setSize(200, 12);

    maxDistanceSlider = skatolo.addSlider("maxDistance")
	.setPosition(30, 90)
	.setRange(0, 80)
	.setSize(80, 12);

    maxDistanceInitSlider = skatolo.addSlider("maxDistanceInit")
	.setPosition(200, 90)
	.setRange(0, 500)
	.setSize(250, 12);

    minCompoSizeSlider = skatolo.addSlider("minCompoSize")
	.setPosition(30, 110)
	.setRange(1, 200)
	.setSize(200, 12);

    normalSlider = skatolo.addSlider("normalFilter")
	.setPosition(410, 110)
	.setRange(-1, 3)
	.setSize(50, 12);

    
    minHeightSlider = skatolo.addSlider("minHeight")
	.setPosition(30, 130)
	.setRange(0, 50)
	.setSize(200, 12);

    forgetTimeSlider = skatolo.addSlider("forgetTime")
	.setPosition(30, 150)
	.setRange(0, 1000)
	.setSize(200, 12);
    trackingMaxDistanceSlider = skatolo.addSlider("trackingMaxDistance")
	.setPosition(30, 160)
	.setRange(10, 1000)
	.setSize(200, 12);

    precisionSlider = skatolo.addSlider("precision")
	.setPosition(30, 170)
	.setRange(1, 8)
	.setSize(200, 12);

    planeHeightSlider = skatolo.addSlider("planeHeight")
	.setPosition(30, 190)
	.setRange(1, 150)
	.setSize(300, 12);

    planeUpAmountSlider = skatolo.addSlider("planeUpAmount")
	.setPosition(30, 210)
	.setValue(1.0f)
	.setRange(1, 50)
	.setSize(200, 12);

    skatolo.addButton("planeUp")
	.setPosition(30, 240)
	.setSize(30, 30);
    skatolo.addButton("planeDown")
	.setPosition(30, 270)
	.setSize(30, 30);

    // TODO: remove this clean. 
    // switchTo3DButton = skatolo.addButton("switch3D")
    // 	.setPosition(30, 320)
    //     .setLabel("Switch To 3D")
    // 	.setSize(30, 30);

    skatolo.addButton("saveButton")
	.setPosition(90, 320)
        .setLabel("Save")
	.setSize(30, 30);


    skatolo.addToggle("mouseControl")
	.setPosition(30, 370)
	.setSize(30, 30);

    depthAnalysisRadio = skatolo.addRadioButton("depthAnalysisRadio")
	.setPosition(600,560)
	.setSize(40,20)
	.setColorForeground(color(120))
	.setColorActive(color(255))
	.setColorLabel(color(255))
	.setItemsPerRow(5)
	.setSpacingColumn(50)
	.addItem("2D passe 1",0)
	// .addItem("200",3)
	// .addItem("250",4)
	;


    depthVisuRadio = skatolo.addRadioButton("depthVisuType")
	.setPosition(600,600)
	.setSize(40,20)
	.setColorForeground(color(120))
	.setColorActive(color(255))
	.setColorLabel(color(255))
	.setItemsPerRow(5)
	.setSpacingColumn(50)
	.addItem("Color",0)
	.addItem("Normal",1)
	.addItem("ID" ,2)
	// .addItem("200",3)
	// .addItem("250",4)
	;

    
     // for(Toggle t:radioButton.getItems()) {
     // 	 t.captionLabel().setColorBackground(color(255,80));
     // 	 t.captionLabel().getStyle().moveMargin(-7,0,0,-3);
     // 	 t.captionLabel().getStyle().movePadding(7,0,0,3);
     // 	 t.captionLabel().getStyle().backgroundWidth = 45;
     // 	 t.captionLabel().getStyle().backgroundHeight = 13;
     // }

    
    // Manual draw.
    skatolo.setAutoDraw(false);

    textFont(createFont("",15));
}

int depthVisuType = 0;

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(depthAnalysisRadio)) {
      int id = (int) theEvent.getValue();
      if(id >= 0 && id <3){
	  currentCalib = id;
	  loadCalibrationToGui(touchDetections[id].getCalibration());
      }
  }

  if(theEvent.isFrom(depthVisuRadio)) {
      int id = (int) theEvent.getValue();
      if(id >= 0 && id <3){
	  depthVisuType = id;
      }
  }

}

float planeUpAmount;

void planeUp(){
    planeCalibration.moveAlongNormal(-planeUpAmount);
}

void planeDown(){
    planeCalibration.moveAlongNormal(planeUpAmount);
}
