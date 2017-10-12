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

    PImage img = touchInput.getCurrentImage();
    if(img != null){
    	fill(255);
    	noStroke();
    	rect(299, 299, 202, 202);
    	image(img, 0, 0, 640, 480);
    	noStroke();
    }else {
    }

    stroke(255);
    fill(50, 50, 255);
    colorMode(HSB, 30);
    ArrayList<TrackedElement> touchs2D = new ArrayList<TrackedElement>(touchInput.getTrackedElements());
    for(TrackedElement tp : touchs2D){
	stroke(1, 0, 30);
    	fill(tp.getID(), 30, 30);
    	PVector pos = tp.getPosition();
	PVector pos2 = (PVector) tp.attachedObject; 
	println("p1 : " +pos);

	ellipse(pos.x, pos.y, 20, 20);
	println("p2 : " +pos2);
	
	if(pos2 != null){

	    ellipse(width- pos2.x ,
		    height- pos2.y,
		     //		     height -pos2.y - height/2,
		    10, 10);

	    // float x = pos2.x + width/2;
	    // float y = pos2.y*2 + height;
	    // float x = (pos2.x * pos2.z);
	    // float y = (pos2.y * pos2.z);
	    // println("X: " + x  + " y: " + y);
	    // ellipse(x, y, 12, 12);
	    	    
	}
    }


}


void drawProjDisplay(){
    PGraphicsOpenGL g = projector.beginDraw();
    g.background(0, 0, 0);
    // colorMode(RGB, 255);

    g.translate(0, 0, 800);
    g.ellipse(0, 0, 50, 50);
    g.translate(0, 0, -800);
	
    g.fill(50, 50, 255);
    g.colorMode(HSB, 30);
    ArrayList<TrackedElement> touchs2D = new ArrayList<TrackedElement>(touchInput.getTrackedElements());
    
    for(TrackedElement tp : touchs2D){
    	g.fill(tp.getID(), 30, 30);
    	PVector pos = tp.getPosition();
	// ellipse((float) pos.x,
    	// 	(float) pos.y, 20, 20);
	g.pushMatrix();
	g.translate(pos.x, pos.y, pos.z);
	g.ellipse(0, 0, 20, 20);
	g.popMatrix();

	PVector pos2 = (PVector) tp.attachedObject; 

	if(pos2 != null){
	    g.pushMatrix();
	    println("pos : " + pos2);
	    // println("pos2a:" + (pos2.y + height/2));
	    g.translate(pos2.x,
			-pos2.y,
			pos2.z);
	    g.ellipse(0, 0, 20, 20);
	    g.popMatrix();
	}
    }

    projector.endDraw();
    
    DrawUtils.drawImage((PGraphicsOpenGL)this.g,
    			projector.render(),
    			0, 0, width, height);
}
