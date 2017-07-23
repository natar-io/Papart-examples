// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import processing.video.*;


Papart papart;

void settings(){
    size(200, 200, P3D);
}

public void setup() {

    // set the quality.
    // 2 is  2x2 pixels rendered for 1 pixel captured for the camera.
    // Default is 1.  Try to set less ( like 0.5f) or more (like 3.0f)
    // and resize the window
    papart = Papart.seeThrough(this, 0.8f);
    papart.loadSketches();
    papart.startTracking();
}

void draw() {
}
