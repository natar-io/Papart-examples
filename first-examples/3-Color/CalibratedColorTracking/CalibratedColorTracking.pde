import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;
import tech.lity.rea.colorconverter.*;

Papart papart;
CalibratedColorGUI paperScreen;

void settings() {
  size(640, 480, P3D);
}
void setup() {
  papart = Papart.seeThrough(this);
  paperScreen = new CalibratedColorGUI();
  papart.startTracking();
}

void draw() {
}
