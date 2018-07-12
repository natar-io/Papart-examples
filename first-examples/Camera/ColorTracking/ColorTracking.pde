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

void settings() {
    size(640, 480, P3D);
}
void setup() {
  papart = Papart.projection(this);
  // papart = Papart.seeThrough(this);
  papart.loadSketches() ;
  papart.startTracking() ;
}

void draw() {
}
