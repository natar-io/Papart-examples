import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.calibration.*;
import org.openni.*;

import toxi.geom.*;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.freenect;
import org.bytedeco.javacpp.opencv_core.*;
import java.nio.IntBuffer;

import peasy.*;
import java.util.Iterator;
import java.util.ArrayList;

PFont font;
DepthTouchInput touchInput;

void settings(){
    fullScreen(P3D);
}

void setup(){

    Papart papart = Papart.projection2D(this);
    papart.loadTouchInput();
    touchInput = (DepthTouchInput) papart.getTouchInput();
    papart.startDepthCameraThread();

    font = loadFont("WCRhesusBBta-48.vlw");
}

IplImage img;
IplImage imgDepth;

void draw(){
    drawBlood();

}

boolean perCentChance(float value){
    return random(1) <  (value / 100f);
}
