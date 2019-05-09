// PapARt library
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.openni.*;

Papart papart;
TouchDetectionDepth fingerDetection;
TableScreen tableContent;

void settings(){
    fullScreen(P3D);
}

public void setup() {
    papart = Papart.projection(this);
    fingerDetection = papart.loadTouchInput().initHandDetection();
    tableContent = new TableContent();
    papart.startTracking();
}

void draw() {}
