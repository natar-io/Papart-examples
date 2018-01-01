// PapARt library
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import toxi.geom.*;
import processing.video.*;

void settings(){
    size(200, 200, P3D);
}

ARDisplay display;
Camera camera;

public void setup(){
    Papart papart = Papart.seeThrough(this);


    display = papart.getARDisplay();
    // Do not draw automatically.
    display.manualMode();
    camera = display.getCamera();

    papart.loadSketches();
    papart.startTracking();

}

void draw(){


    // Nothing is drawn directly here.
    display.drawScreens();
    
    noStroke();

    // draw the camera image
    if (camera != null && camera.getPImage() != null) {
        image(camera.getPImage(), 0, 0, width, height);
    }

    // draw the AR
    display.drawImage((PGraphicsOpenGL) g, display.render(),
                      0, 0, width, height);
    
    if(rer != null){
	fill(255);
	translate(0, 50);
	findFreq(rer, imr, "red");
	fill(255);
	translate(0, 120);
	findFreq(reg, img, "green");
    }
}

void findFreq(float[] re, float im[], String name){
	float max = 0;
	int id = 0;
	int x = 0;
	int y = 0;
	noStroke();
	for(int i = 2; i < re.length / 2; i++){
	    //	    float v = abs(re[i]);
	    float v = sqrt(re[i] * re[i] + im[i]* im[i]);
	    if(v > max){
		max = v;
		id = i;
	    }
	    rect(i *3, y, 2, v * 2);
	}
	fill(255, 0, 0);
	rect(id* 3, y, 1, max);

	float f = + (float)id / (float)ech * (float)freq * 2;
	text(name + " " + f, 0, 0);
	println(name+": " + id + " f: "+ f);

    
}


float[] re, im;

float[] rer, imr;
float[] reg, img;

boolean test = false;
void keyPressed(){

    if(key == 't'){
	test = !test;
    }
}
