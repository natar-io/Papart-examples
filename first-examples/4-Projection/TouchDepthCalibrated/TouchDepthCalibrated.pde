import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import tech.lity.rea.svgextended.*;
import tech.lity.rea.colorconverter.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import org.openni.*;

import redis.clients.jedis.*;

Papart papart;
PaperTouchScreen touchDepthView;

boolean DRAW_ARM = true, DRAW_HAND = true, DRAW_FINGER = true, DRAW_TIP = true;

void settings(){
    fullScreen(P3D);
}

public void setup() {
    papart = Papart.projection(this);
    papart.loadTouchInput().initHandDetection();
    touchDepthView = new TouchDepthView();
    papart.startTracking();
}

void draw() {}

void keyPressed() {
  if (key == 'a') {
    DRAW_ARM = !DRAW_ARM;
  }

  if (key == 'h') {
    DRAW_HAND = !DRAW_HAND;
  }

  if (key == 'f') {
    DRAW_FINGER = !DRAW_FINGER;
  }

  if (key == 't') {
    DRAW_TIP = !DRAW_TIP;
  }
}
