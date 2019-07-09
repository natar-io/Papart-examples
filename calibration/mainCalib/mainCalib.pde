// Natar
import tech.lity.rea.nectar.camera.*;
// import tech.lity.rea.javacvprocessing.*;

import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.calibration.MultiCalibrator;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;

import org.openni.*;

import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.skatolo.Skatolo;

import tech.lity.rea.colorconverter.*;

import redis.clients.jedis.*;

float renderQuality = 1.0f;
Papart papart;
boolean useProjection = true;

void settings(){
    if(useProjection){
	fullScreen(P3D);
    }else  {
	size(640, 480, P3D);
    }
}
// NECTAR:  ./chilitags-server -i projector0 -o projector0:markers -s -v --camera-parameters projector0

// Pose -- ?
// natar-app tech.lity.rea.nectar.apps.MultiPoseEstimator -i projector0 -x -v

// ARUCO FTW
// natar-tracker-aruco -i projector0 -o projector0:markers -s -v --camera-parameters projector0

// ARTOOKLIT
// natar-tracker-artoolkitplus --input projector0 --output projector0:markers --camera-parameters projector0 --calibration-file /usr/share/natar/natar-tracker-artoolkitplus-git/no_distortion.cal --markerboard-file /usr/share/natar/natar-tracker-artoolkitplus-git/markerboard_480-499.cfg --stream -g -v


 void setup(){
     try{
     if(useProjection){
	 papart = Papart.projection(this);
	 papart.loadTouchInput().initHandDetection();
     }else{
	 papart = Papart.seeThrough(this);
     }
     }catch(Exception e){
	 e.printStackTrace();
     }
     //      papart.loadSketches();
     papart.startTracking();


     MultiCalibrator.PAPER = "calib2";
     MultiCalibrator.ZSHIFT = -10f;
     //      MultiCalibrator.SCALE_FACTOR = 229.5f / 240.0f;
     // MultiCalibrator.SCALE_FACTOR = 238.5f / 240.2f;
 }


void draw(){
    //    println("Framerate: "  + frameRate);
}


boolean test = false;

void keyPressed() {
    if(key == 't')
	test = !test;

    if(key == 'a'){
	MultiCalibrator.CENTER_X++;
	println("CX: "+	MultiCalibrator.CENTER_X);
    }

    if(key == 'A'){
	MultiCalibrator.CENTER_X--;
	println("CX: "+	MultiCalibrator.CENTER_X);
	}

    if(key == 'b'){
	MultiCalibrator.CENTER_Y++;
	println("CY: "+	MultiCalibrator.CENTER_Y);
    }

    if(key == 'B'){
	MultiCalibrator.CENTER_Y--;
	println("CY: "+	MultiCalibrator.CENTER_Y);
	}

    
    if(key == 'c'){
        papart.multiCalibration();
	papart.multiCalibrator.disableColor();
    }

    // TEST
    // save the touch calibration 
    if(key == 's'){
	papart.multiCalibrator.toSave = true;	
    }
    // if(key == 'e'){
    // 	papart.multiCalibrator.evaluateMode = !papart.multiCalibrator.evaluateMode;
    // }

    // if(key == 's')
    // 	papart.setTableLoca(tion(app);
    
}


