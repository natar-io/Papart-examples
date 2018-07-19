// PapARt library
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.openni.*;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

import tech.lity.rea.colorconverter.*;


Papart papart;
TouchDetectionDepth fingerDetection;

void settings(){
    fullScreen(P3D);
}

public void setup() {
    papart = Papart.projection(this);
    fingerDetection = papart.loadTouchInput().initHandDetection();
    new LifeGui();
    new LifeRenderer();
    papart.startTracking();
}

PVector initPos = new PVector(-200, -100);
PVector rendererSize = new PVector(200, 200);

float nbTickPerSec = 1;
int lastTick;

void draw() {
    nbTickPerSec = (float) mouseX / 250;
    int now = millis();
    float tickFreq = 1f / nbTickPerSec;
    float tickEvery = 1000f / tickFreq;
    if((now - lastTick) > tickEvery){
	gameOfLife.iterate();
	lastTick = now;
    }
}

void keyPressed(){
    if(key == 'g'){
	gameOfLife.randomSeed();
    }
    if(key == 'i'){
	gameOfLife.iterate();
    }
}
