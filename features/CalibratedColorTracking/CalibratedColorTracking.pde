import toxi.volume.*;

// PapARt library
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import java.awt.Color;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

Papart papart;

void settings() {
<<<<<<< HEAD
     size(640, 480, P3D);
 //  fullScreen(P3D);
}
void setup() {
  // papart = Papart.projection(this);
  papart = Papart.seeThrough(this);
  new MyApp();
=======
    //    size(640, 480, P3D);
    fullScreen(P3D);
}
void setup() {
  papart = Papart.projection(this);
  //    papart = Papart.seeThrough(this);
  papart.loadSketches() ;
>>>>>>> origin/latest
  papart.startTracking() ;
}

void draw() {
}
