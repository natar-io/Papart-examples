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
    size(100, 100, P3D);
    //     fullScreen(P3D);
}

public void setup() {
    papart = Papart.projection(this);
    fingerDetection = papart.loadTouchInput().initHandDetection();
    papart.setDistantCamera("192.168.2.1", 6379);
    papart.streamOutput("192.168.2.1", 6379, "", "display0");
    tableContent = new TableContent();
    papart.startTracking();
}

void draw() {}
