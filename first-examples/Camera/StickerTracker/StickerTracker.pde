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
StickerView sView;

void settings() {
  size(640, 480, P3D);
}
void setup() {
  papart = Papart.seeThrough(this);
  sView = new StickerView();
  papart.startTracking();
}

void draw() {}
