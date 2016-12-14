// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import processing.video.*;
import processing.app.Base;
import fr.inria.skatolo.*;

Papart papart;

void settings() {
  fullScreen(P3D);
}

public void setup() {
  papart = Papart.projection(this);
  papart.loadSketches();
  papart.startTracking();
}

void draw() {
}

void keyPressed() {
  app.loadLocationFrom(Papart.folder + "savedLocations/loc.xml");
  app.getLocation().print();
}
