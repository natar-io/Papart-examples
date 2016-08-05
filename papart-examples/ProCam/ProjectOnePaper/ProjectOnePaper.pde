import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.skatolo.Skatolo;

float renderQuality = 1.5f;
Papart papart;

void settings(){
    fullScreen(P3D);
}

 void setup(){
     Papart.calibrationFileName = "mega-calib.svg";
     papart = Papart.projection(this);
     papart.loadSketches();
     papart.startTracking();
}

void draw(){
}

void keyPressed() {
    if(key == 'c')
        papart.calibration();
}