import toxi.volume.*;

// PapARt library
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import java.awt.Color;


void settings() {
    size(640, 480, P3D);
}

void setup() {
  Papart papart = Papart.seeThrough(this);
  papart.loadSketches() ;
  papart.startTracking() ;
}

void draw() {
}
