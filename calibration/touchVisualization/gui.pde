Slider recursionSlider, searchDepthSlider;
Slider maxDistanceSlider, minCompoSizeSlider;
Slider minHeightSlider;
Slider forgetTimeSlider;
Slider trackingMaxDistanceSlider;
Slider precisionSlider;
Slider planeHeightSlider;
Slider planeUpAmountSlider;

Button switchTo3DButton;

void initGui(){

    skatolo = new Skatolo(this);
    recursionSlider = skatolo.addSlider("recursion")
	.setPosition(30, 50)
	.setRange(1, 500)
	.setSize(200, 12);

    searchDepthSlider = skatolo.addSlider("searchDepth")
	.setPosition(30, 70)
	.setRange(1, 50)
	.setSize(200, 12);

    maxDistanceSlider = skatolo.addSlider("maxDistance")
	.setPosition(30, 90)
	.setRange(0, 1000)
	.setSize(400, 12);


    minCompoSizeSlider = skatolo.addSlider("minCompoSize")
	.setPosition(30, 110)
	.setRange(1, 50)
	.setSize(200, 12);

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
	.setRange(1, 2000)
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

    switchTo3DButton = skatolo.addButton("switch3D")
	.setPosition(30, 320)
        .setLabel("Switch To 3D")
	.setSize(30, 30);

    skatolo.addButton("saveButton")
	.setPosition(90, 320)
        .setLabel("Save")
	.setSize(30, 30);


    skatolo.addToggle("mouseControl")
	.setPosition(30, 370)
	.setSize(30, 30);


    // Manual draw.
    skatolo.setAutoDraw(false);

    textFont(createFont("",15));
}

float planeUpAmount;

void planeUp(){
    planeCalibration.moveAlongNormal(-planeUpAmount);
}

void planeDown(){
    planeCalibration.moveAlongNormal(planeUpAmount);
}
