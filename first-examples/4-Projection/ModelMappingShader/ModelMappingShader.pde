import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import processing.video.*;
import TUIO.*;
import toxi.geom.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.skatolo.Skatolo;
import org.openni.*;

Papart papart;
ModelMapper mMapper;

void settings() {
  fullScreen(P3D);
}
void setup() {
  papart = Papart.projection(this);
  papart.loadTouchInput().initHandDetection();
  mMapper = new ModelMapper();
  papart.startTracking();
}


void draw() {}
