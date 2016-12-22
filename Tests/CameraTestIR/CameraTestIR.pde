// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.tracking.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacv.RealSenseFrameGrabber;
import processing.video.*;

import org.bytedeco.javacv.Frame;
import fr.inria.papart.procam.Utils;
import org.bytedeco.javacv.*;

Camera camera, camera2;
CameraRGBIRDepth cameraMulti, cameraMulti2;
TrackedView boardView, boardView2;
MarkerBoard markerBoard;

int resX = 512;
int resY = 424;

void settings(){
    size(640 * 2, 480 * 2, OPENGL);
    // size(resX, resY, OPENGL);
}


public void setup() {

    Papart papart = new Papart(this);
    
    if (surface != null) {
	surface.setResizable(true);
    }

    // camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0");
    // camera = CameraFactory.createCamera(Camera.Type.OPENCV, "0");
    // camera = CameraFactory.createCamera(Camera.Type.PROCESSING, "/dev/video1");
    // camera = CameraFactory.createCamera(Camera.Type.FLY_CAPTURE, 0);

    // camera = CameraFactory.createCamera(Camera.Type.FFMPEG, "/dev/video1");
    // camera = CameraFactory.createCamera(Camera.Type.FFMPEG, ":0.0+200,200", "x11grab");

     // camera = CameraFactory.createCamera(Camera.Type.REALSENSE, "0");
     // cameraMulti = (CameraRGBIRDepth) camera;

    try{

        camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0", "ir");
	camera2 = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "1", "ir");
	
	// camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT, "0", "ir");
	// camera = CameraFactory.createCamera(Camera.Type.OPEN_KINECT_2, "0", "rgb");

	cameraMulti = (CameraRGBIRDepth) camera;
	cameraMulti2 = (CameraRGBIRDepth) camera2;
	//	cameraMulti.actAsColorCamera();

	//	cameraMulti.setUseDepth(true);
	// cameraMulti.setUseColor(true);
	//	cameraMulti.setUseIR(true);

	// cameraMulti.getColorCamera().setSize(1280, 720);
	// cameraMulti.getIRCamera().setSize(640, 480);
	
	//	camera.setSize(640, 480);
	//	camera.setSize(1280, 720);
	camera.setParent(this);
	camera2.setParent(this);

	markerBoard =
	    //	    MarkerBoardFactory.create(Papart.markerFolder + "A4-calib.svg",
	    MarkerBoardFactory.create(Papart.markerFolder + "legacy/big-calib.svg",
				      297, 210);
	

	// System.out.println("cam " + cameraMulti.getIRCamera() + "board " + markerBoard);
	cameraMulti.getIRCamera().trackMarkerBoard(markerBoard);
	cameraMulti2.getIRCamera().trackMarkerBoard(markerBoard);

	cameraMulti.getIRCamera().setCalibration(Papart.cameraCalib);
	cameraMulti2.getIRCamera().setCalibration(Papart.cameraCalib);

	markerBoard.setDrawingMode(cameraMulti, true, 10);
	markerBoard.setFiltering(cameraMulti, 30, 4);
	markerBoard.setDrawingMode(cameraMulti2, true, 10);
	markerBoard.setFiltering(cameraMulti2, 30, 4);

	
	// markerBoard.setDrawingMode(cameraTracking, true, 10);
	// markerBoard.setFiltering(cameraTracking, 30, 4);

	boardView = new TrackedView(markerBoard);
	boardView.setImageWidthPx(256);
	boardView.setImageHeightPx(256);
	boardView.init();


	boardView2 = new TrackedView(markerBoard);
	boardView2.setImageWidthPx(256);
	boardView2.setImageHeightPx(256);
	boardView2.init();

	// boardView.setBottomLeftCorner(new PVector(63, 45));


	
	cameraMulti.getIRCamera().trackSheets(true);
	cameraMulti2.getIRCamera().trackSheets(true);

	//    ((CameraFlyCapture) camera).setBayerDecode(true);
	camera.start();
	camera2.start();

	camera.setThread();
	camera2.setThread();

        } catch(Exception e ){
	e.printStackTrace();
    }

    // videoOut = createImage(1280, 720, RGB);
    //    frameRate(1000);
}



// PImage videoOut;
void draw() {

    background(0);


    // camera.grab();
    // camera2.grab();

    
    // PImage im = camera.getPImage();
    // if(im != null){
    // 	println("image OK");
    // 	image(im, 0, 0, width, height);
    // } else {
    // 	println("image null");
    // }
    
    // }catch(Exception e){
    // 	e.printStackTrace();
    // }
    
    //    PImage imRGB = cameraMulti.getColorImage();
    PImage imIR = cameraMulti.getIRImage();
    PImage imIR2 = cameraMulti2.getIRImage();
    // PImage imDepth = cameraMulti.getDepthPImage();

    
    // if(imRGB != null){
    // 	image(imRGB, 0, 0, 640, 480);
    // }
    if(imIR != null){
    	image(imIR, 0, 0, 640, 480);
    }
    if(imIR2 != null){
    	image(imIR2, 640, 0, 640, 480);
    }

    println("First cam pos");
    markerBoard.getTransfoMat(cameraMulti.getIRCamera()).print();
    println("Second pos");
    markerBoard.getTransfoMat(cameraMulti2.getIRCamera()).print();


    PImage out = boardView.getViewOf(cameraMulti.getIRCamera());
    PImage out2 = boardView2.getViewOf(cameraMulti2.getIRCamera());

    //    println("out " + out);
    
    if(out != null){
    	image(out, 0, 480, 640, 480);
    }
    if(out2 != null){
    	image(out2, 640, 480, 640, 480);
    }

    // if(imDepth != null){
    // 	image(imDepth, 0, 480, 640, 480);
    // }

    // } catch(Exception e ){
    // 	e.printStackTrace();
    // }
}
