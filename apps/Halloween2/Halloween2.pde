import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.calibration.*;

import toxi.geom.*;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.freenect;
import org.bytedeco.javacpp.opencv_core.*;
import java.nio.IntBuffer;

import peasy.*;
import java.util.Iterator;
import java.util.ArrayList;

PFont font;
KinectTouchInput touchInput;

void settings(){
    fullScreen(P3D);
}

void setup(){

    Papart.projection2D(this);
    Papart papart = new Papart(this);

    // arguments are 2D and 3D precision.
    papart.loadTouchInputKinectOnly();
    touchInput = (KinectTouchInput) papart.getTouchInput();

    font = loadFont("WCRhesusBBta-48.vlw");
}

IplImage kinectImg;
IplImage kinectImgDepth;

void draw(){
    drawBlood();

}


boolean perCentChance(float value){
    return random(1) <  (value / 100f);
}
