import fr.inria.papart.depthcam.devices.KinectOne;
import fr.inria.papart.procam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.opencv_core.*;

class TestView extends PApplet {

    Papart papart;
    boolean isTestingProjector = false;
    boolean isTestingCamera = false;
    boolean isTestingDepthCamera = false;

    Camera camera;
    DepthCameraDevice depthCamera;

    void show(){
        this.getSurface().setVisible(true);
    }

    void hide(){
        this.getSurface().setVisible(false);
    }

    public TestView() {
        super();
        PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    }

    public void settings() {
        size(640, 480, P3D);
        smooth();

    }

    public void setup() {
        papart = new Papart(this);
        hide();
    }

    public void testProjector(){

        updateScreenConfig();
        papart.forceProjectorSize(screenConfig.getProjectionScreenWidth(),
                                  screenConfig.getProjectionScreenHeight(),
                                  screenConfig.getProjectionScreenOffsetX(),
                                  screenConfig.getProjectionScreenOffsetY());
        this.isTestingProjector = true;
        show();
    }

    public void testCamera(){
        cameraConfig.setCameraName(cameraIdText.getText());
	    setFormat();

	    try{
	    camera = cameraConfig.createCamera();

	    }catch(CannotCreateCameraException e){
		println("Error cannot create the camera !");
		exit();
	    }
        camera.setParent(this);

        int w = 640, h = 480;

        if(cameraCalibrationOk){
            w = cameraWidth;
            h = cameraHeight;
        }

        papart.forceWindowSize(w, h);
        camera.setSize(w, h);
        camera.start();
	//        camera.setThread();

        this.isTestingCamera = true;

        show();
    }


    public void testDepthCamera(){
        if(depthCameraConfig.getCameraType() == Camera.Type.FAKE){
            return;
        }
        depthCameraConfig.setCameraName(cameraIdText.getText());
	
	try{
	    camera = depthCameraConfig.createCamera();
	}catch(CannotCreateCameraException e){
	    println("Error cannot create the depth camera !");
	    exit();
	}
        camera.setParent(this);

	try{

        if(depthCameraConfig.getCameraType() == Camera.Type.OPEN_KINECT_2){
            depthCamera = new KinectOne(this, camera);
        }

        if(depthCameraConfig.getCameraType() == Camera.Type.OPEN_KINECT){
            depthCamera = new Kinect360(this, camera);
        }

        if(depthCameraConfig.getCameraType() == Camera.Type.REALSENSE){
            depthCamera = new RealSense(this, camera);
        }

	}catch(CannotCreateCameraException e){
	    println("Error cannot create the depth camera !");
	    exit();
	}

	((CameraRGBIRDepth)camera).actAsDepthCamera();
	//        camera.setThread();

        papart.forceWindowSize(camera.width(), camera.height());

        this.isTestingDepthCamera = true;
        show();
    }

    public void draw() {
        if(isTestingCamera || isTestingDepthCamera)
            drawCamera();
        if(isTestingProjector){
            drawProjector();
        }
    }

    void drawCamera(){
	camera.grab();

        PImage im = null;
	if(isTestingDepthCamera){
	    im = ((CameraRGBIRDepth)camera).getDepthCamera().getPImage();
	} else {
	    im = camera.getPImage();
	}

        if(im != null)
            image(im, 0, 0, width, height);
    }

    void drawProjector(){
	background(100);
	rect(0, 0, rectSize, rectSize);
	rect(width-rectSize, 0, rectSize, rectSize);
	rect(width-rectSize, height-rectSize, rectSize, rectSize);
	rect(0, height-rectSize, rectSize, rectSize);

    }

    void keyPressed(){

        println("Key  !");
        if (key == 27) { //The ASCII code for esc is 27, so therefore: 27

            println("Key 27 !");
            this.getSurface().setVisible(false);
            if(isTestingCamera){
                closeCurrentStream();
                isTestingCamera = false;
            }
            if(isTestingProjector){
                isTestingProjector = false;
            }
            if(isTestingDepthCamera){
                closeCurrentStream();
                isTestingDepthCamera = false;
            }

            hide();
        }
        if (key == ESC)
            key=0;

    }

    void closeCurrentStream(){

        if(isTestingCamera){
            println("Closing " + camera);
            camera.stopThread();
            camera.close();
            camera = null;
            println("Closed !");
        }

        if(isTestingDepthCamera){
            camera.stopThread();
	    //            depthCamera.close();
            camera = null;
            depthCamera = null;
        }
    }

    // public void close(){
    //     camera.close();
    // }
}
