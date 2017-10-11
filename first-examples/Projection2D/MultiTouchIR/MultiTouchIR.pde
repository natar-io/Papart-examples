import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.tracking.*;

import org.bytedeco.javacv.*;
import toxi.geom.*;


ColorTouchInput touchInput;

void settings(){
    fullScreen(P3D);
}

ProjectorDisplay projector;
boolean useProjDisplay = false;

void setup(){
    Papart papart;

    if(useProjDisplay){
	papart= Papart.projectionOnly(this);
	projector = papart.getProjectorDisplay();
	projector.manualMode();
    } else {
   	papart = Papart.projection2D(this);
	papart.loadDefaultProjector();
    }
    // arguments are 2D and 3D precision.
    papart.loadIRTouchInput();
    touchInput = (ColorTouchInput) papart.getTouchInput();

    papart.startCameraThread();

    frameRate(200);
}

void draw(){

    if(useProjDisplay){
	drawProjDisplay();
    } else {
	draw2D();
    }

}

void draw2D(){
    background(0, 0, 0);
    // colorMode(RGB, 255);
    fill(50, 50, 255);
    colorMode(HSB, 30);
    ArrayList<TrackedElement> touchs2D = new ArrayList<TrackedElement>(touchInput.getTrackedElements());
    
    for(TrackedElement tp : touchs2D){
    	fill(tp.getID(), 30, 30);
    	PVector pos = tp.getPosition();
	pushMatrix();
	translate( pos.x,
		   pos.y,
		  0);
	ellipse(0, 0, 20, 20);
	popMatrix();
    }


}


void drawProjDisplay(){
    PGraphicsOpenGL g = projector.beginDraw();
    g.background(0, 0, 0);
    // colorMode(RGB, 255);
    
    g.fill(50, 50, 255);
    g.colorMode(HSB, 30);
    ArrayList<TrackedElement> touchs2D = new ArrayList<TrackedElement>(touchInput.getTrackedElements());
    
    for(TrackedElement tp : touchs2D){
    	g.fill(tp.getID(), 30, 30);
    	PVector pos = tp.getPosition();
	// println("p: " + pos);
	// ellipse((float) pos.x,
    	// 	(float) pos.y, 20, 20);
	g.pushMatrix();

	g.translate(pos.x, pos.y, pos.z);
	g.ellipse(0, 0, 20, 20);
	g.popMatrix();
    }
    println("Framerate "+ frameRate);

    projector.endDraw();

    DrawUtils.drawImage((PGraphicsOpenGL)this.g,
			projector.render(),
			0, 0, width, height);

}
