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

void settings(){
    size(640, 480, P3D);
}

 void setup(){
     papart = Papart.seeThrough(this);
     papart.startTracking();

     MultiCalibrator.PAPER = "calib2";
     MultiCalibrator.SCALE_FACTOR = 229.5f / 240.0f;
 }


void draw(){

}

boolean test = false;

void keyPressed() {
    if(key == 't')
	test = !test;

    if(key == 'c')
        papart.multiCalibration(true);
}
