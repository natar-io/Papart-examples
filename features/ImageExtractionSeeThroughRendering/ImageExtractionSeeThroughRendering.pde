// PapARt library
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

void settings(){
    size(640, 480, P3D);
}

public void setup(){
    Papart papart = Papart.seeThrough(this);
    new MyApp();
    papart.startTracking();
}

void draw(){

}
