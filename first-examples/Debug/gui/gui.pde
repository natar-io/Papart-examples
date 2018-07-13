// PapARt library
import fr.inria.papart.procam.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;

TUIOTouchInput touchInputTuio;

void settings(){
    size(640, 480, OPENGL);
}

public void setup(){
    Papart papart = new Papart(this);
    papart.initDebug();
    touchInputTuio = papart.loadTouchInputTUIO();
    new MyApp();
}

void draw(){

}

boolean mouseSetLocation = false;

void keyPressed(){
    if(key == 'l'){
	mouseSetLocation = !mouseSetLocation;
    }

}
