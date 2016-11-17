Textfield cameraIdText, cameraFormatText, posXText, posYText;
Textfield depthCameraIdText;
Textfield cameraName;
Textfield depthCameraName;

RadioButton screenChooser, cameraType, depthCameraType, cameraSubType;

Button startCameraButton, saveDefaultCameraButton;
Button startDepthCameraButton, saveDefaultDepthCameraButton;
Button initButton, saveDefaultScreenButton;
Toggle useCalibration;
Button loadCalibrationCamera, loadCalibrationProjector;
    
PFont myFont;
ControlFont cFont;
CColor cColor;
CColor cColorToggle;

PImage testCameraImg;

boolean useCameraCalibration;

final int RGB_FORMAT=0;
final int IR_FORMAT=1;
final int DEPTH_FORMAT=2;

void initUI() {

  myFont = createFont("arial", 20);
  skatolo = new Skatolo(this);

  // skatolo.setColorForeground(color(200,0));

  // skatolo.setColorLabel(color(0,0,0,0));
  //  skatolo.setColorValue(color(0,0,0,0));
  //  skatolo.setColorActive(color(161,4,4,0));

  // skatolo.setColorBackground(color(200,0));

  PFont pfont = loadFont("data/Serif.plain-13.vlw"); // use true/false for smooth/no-smooth
  cFont = new ControlFont(pfont, 13);

  cColor = new CColor(color(134, 171, 242),
    color(51),
    color(71),
    color(255),
    color(255));


  cColorToggle = new CColor(color(134, 171, 242),
    color(120),
    color(219),
    color(255),
    color(255));


  initScreenUI();
  initCameraUI();
  initDepthCameraUI();

  updateStyles();
}

void initScreenUI() {
  screenChooser = skatolo.addRadioButton("screenChooserRadio")
    .setPosition(50, 100)
    .setLabel("Screen Chooser")
    .toUpperCase(false)
    .setItemWidth(20)
    .setItemHeight(20)
    .setColorLabel(color(255))
    .activate(0)
    ;

  String[] descriptions = CanvasFrame.getScreenDescriptions();
  int k = 0;
  for (String description : descriptions) {
    println(description);
    DisplayMode displayMode = CanvasFrame.getDisplayMode(k);
    screenChooser.addItem("Screen "
      + description
      + " -- Resolution  " + displayMode.getWidth()
      + "x" + displayMode.getHeight(), k);

    k++;
  }
  nbScreens = k;

  posXText = skatolo.addTextfield("PosX")
    .setPosition(417, 100)
    .setSize(80, 20)
    .setFont(myFont)
    .setLabel("Position X")
    .setText(Integer.toString(screenConfig.getProjectionScreenOffsetX()))
    ;

  posYText = skatolo.addTextfield("PosY")
    .setPosition(417, 150)
    .setSize(80, 20)
    .setFont(myFont)
    .setLabel("Position Y")
    .setText(Integer.toString(screenConfig.getProjectionScreenOffsetY()))
    ;

  loadCalibrationProjector = skatolo.addButton("loadProjectorCalibration")
      .setLabel("Load Calibration")
      .setPosition(200, 197)
      .setSize(140,20)
      ;


  initButton = skatolo.addButton("testProjection")
    .setPosition(611, 102)
    .setLabel("Test Projection")
    .setSize(110, 20)
    ;

  saveDefaultScreenButton = skatolo.addButton("saveDefaultScreen")
    .setPosition(611, 143)
    .setLabel("Save as default")
    .setSize(110, 20)
    ;

}

void initCameraUI() {

    // This follows the order in Camera.java...
    cameraType = skatolo.addRadioButton("cameraTypeChooser")
        .setPosition(50, 357)
        .setItemWidth(20)
        .setItemHeight(20)
        .addItem("OpenCV", Camera.Type.OPENCV.ordinal())
        .addItem("FFMPEG", Camera.Type.FFMPEG.ordinal())
        .addItem("Processing", Camera.Type.PROCESSING.ordinal())
	    .addItem("RealSense",Camera.Type.REALSENSE.ordinal())
        .addItem("OpenKinect",Camera.Type.OPEN_KINECT.ordinal())
        .addItem("OpenKinect2",Camera.Type.OPEN_KINECT_2.ordinal())
        .addItem("FlyCapture", Camera.Type.FLY_CAPTURE.ordinal())
        .activate(cameraConfig.getCameraType().ordinal())
        ;

    cameraSubType = skatolo.addRadioButton("SubType")
        .setPosition(170, 357)
        .setItemWidth(20)
        .setItemHeight(20)
        .addItem("rgb", RGB_FORMAT)
        .addItem("ir", IR_FORMAT)
        .addItem("depth", DEPTH_FORMAT)
        ;

    loadCalibrationCamera = skatolo.addButton("loadCalibration")
        .setLabel("load calibration")
        .setPosition(250, 420)
        .setSize(140,20)
        ;


    cameraIdText = skatolo.addTextfield("CameraId")
    .setPosition(250, 358)
    .setSize(200, 20)
    .setFont(myFont)
    .setLabel("")
    .setLabelVisible(false)
    .setText(cameraConfig.getCameraName())
    .setFocus(true)
    ;

    cameraFormatText = skatolo.addTextfield("CameraFormat")
        .setPosition(250, 388)
        .setSize(80, 20)
        .setFont(myFont)
        .setLabel("")
        .setLabelVisible(false)
        .setText(cameraConfig.getCameraFormat())
        ;


  testCameraImg = loadImage("data/testCamera.png");

  startCameraButton = skatolo.addButton("testCameraButton")
    .setPosition(611, 369)
    .setLabel("Test the camera")
    .setSize(110, 20)
    ;

  saveDefaultCameraButton = skatolo.addButton("saveDefaultCamera")
    .setPosition(611, 409)
    .setLabel("Save as default")
    .setSize(110, 20)
    ;

}

int getDepthType(int t){
    if(t == Camera.Type.REALSENSE.ordinal())
        return 0;
    if(t == Camera.Type.OPEN_KINECT.ordinal())
        return 1;
    if(t == Camera.Type.OPEN_KINECT_2.ordinal())
        return 2;
    if(t == Camera.Type.FAKE.ordinal())
        return 3;
    return 3;
}

void initDepthCameraUI() {

    int currentType = getDepthType(depthCameraConfig.getCameraType().ordinal());

  depthCameraType = skatolo.addRadioButton("depthCameraTypeChooser")
    .setPosition(50, 652)
    .setItemWidth(20)
    .setItemHeight(20)
      .addItem("RealSense (SR300)", Camera.Type.REALSENSE.ordinal())
      .addItem("OpenKinect (xbox360)", Camera.Type.OPEN_KINECT.ordinal())
      .addItem("OpenKinect2 (xboxOne)", Camera.Type.OPEN_KINECT_2.ordinal())
      .addItem("No DepthCamera", Camera.Type.FAKE.ordinal())
    .setColorLabel(color(255))
      .activate(currentType)
    ;


  depthCameraIdText = skatolo.addTextfield("DepthCameraId")
    .setPosition(250, 652)
    .setSize(200, 20)
    .setFont(myFont)
    .setLabel("")
    .setLabelVisible(false)
    .setText(depthCameraConfig.getCameraName())
    .setFocus(true)
    ;

  startDepthCameraButton = skatolo.addButton("testDepthCameraButton")
    .setPosition(611, 656)
    .setLabel("Test the kinect")
    .setSize(110, 20)
    ;

  saveDefaultDepthCameraButton = skatolo.addButton("saveDefaultDepthCamera")
    .setPosition(611, 696)
    .setLabel("Save as default")
    .setSize(110, 20)
    ;
  
}


void updateStyles() {

  setStyle(screenChooser);
  setStyle(posXText);
  setStyle(posYText);
  setStyle(initButton);
  setStyle(saveDefaultScreenButton);
  setStyle(loadCalibrationProjector);

    setStyle(cameraType);
    setStyle(cameraSubType);
    setStyle(cameraIdText);
    setStyle(cameraFormatText);
  setStyle(startCameraButton);
  setStyle(saveDefaultCameraButton);
  setStyle(loadCalibrationCamera);

  setStyle(depthCameraType);
  setStyle(depthCameraIdText);
  setStyle(startDepthCameraButton);
  setStyle(saveDefaultDepthCameraButton);

}

void setStyle(Controller controller) {
  controller.getCaptionLabel().updateFont(cFont).toUpperCase(false);
  controller.setColor(cColor);
}


void setStyle(RadioButton controller) {
  for (Toggle toggle : controller.getItems()) {
    toggle.getCaptionLabel().updateFont(cFont).toUpperCase(false);
    toggle.setColor(cColorToggle);
  }
}
