import fr.inria.papart.procam.*;
import org.bytedeco.javacpp.*;
import tech.lity.rea.svgextended.*;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

Papart papart;
Internal2DPaperContent iPaperContent;
External3DPaperContent ePaperContent;

PShape rocket;

void settings() {
  size(640, 480, P3D);
}

void setup() {
  Papart papart = Papart.seeThrough(this);

  rocket = loadShape("data/rocket.obj");

  iPaperContent = new Internal2DPaperContent();
  ePaperContent = new External3DPaperContent();

  papart.startTracking();
}

void draw() {}
