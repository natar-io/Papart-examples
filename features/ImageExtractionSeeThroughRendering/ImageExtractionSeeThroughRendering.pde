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
    CameraNectar cam = (CameraNectar) papart.getCameraTracking();
    cam.DEFAULT_REDIS_HOST = "oj.lity.tech";
    cam.DEFAULT_REDIS_PORT = 6389;
    new MyApp();
    papart.startTracking();
}

void draw(){

}
