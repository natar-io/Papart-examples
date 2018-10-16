import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

import redis.clients.jedis.*;

import tech.lity.rea.colorconverter.*;


public class MyApp  extends PaperTouchScreen {

    Skatolo skatolo;
    ColorTracker colorTracker;
    CalibratedStickerTracker stickerTracker;
    
    void settings() {
        setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default-aruco.svg", 297, 210);
	//        setQuality(1f);
    }

    void setup() {

	// Color Tracker
	colorTracker = papart.initBlueTracking(this, 1f);

	// Sticker tracker 
	stickerTracker = new CalibratedStickerTracker(this, 15);

	// Marker tracker
	initTouchListFromMarkers(333, 345, 24, true);
	// 	initTouchListFromMarkers(335, 341, 45, true);
	// GUI
	skatolo = new Skatolo(this.parent, this);
	skatolo.getMousePointer().disable();
	skatolo.setAutoDraw(false);

	skatolo.addHoverButton("button")
	    .setPosition(0, 60)
	    .setSize(60, 60)
	    ;

	skatolo.addHoverToggle("toggle")
	    .setPosition(100, 60)
	    .setSize(60, 60)
	    ;

	skatolo.addHoverKnob("knob")
	    .setRange(0,255)
	    .setValue(50)
	    .setPosition(200,70)
	    .setRadius(50)
	    ;
    }

    boolean toggle = false;
    void button(){
        println("button pressed");
        println("Toggle value " + toggle);
	rectColor += 30;
    }

    float rectColor = 0;
    
    void drawOnPaper(){
	// setLocation(63, 45, 0);
        background(10);

	TouchList allTouchs = new TouchList();

	// MOUSE
	SkatoloLink.addMouseTo(allTouchs, skatolo, this); // comment to disable

	// Marker
	TouchList markerTouchs = getTouchListFromMarkers();
	drawMarkers(markerTouchs);
	allTouchs.addAll(markerTouchs);  // comment to disable
	// println("Markers: ");
	// for(Touch t : markerTouchs){
	//     t.id = 3
	//     println("t: " + t.position);
	// }


	// STICKER
	stickerTracker.findColor(millis());
	TouchList stickerTouchs = getTouchListFrom(stickerTracker);
	for(Touch t : stickerTouchs){
	    t.id = 3;
	}


	allTouchs.addAll(stickerTouchs);   // comment to disable

	// COLOR
	colorTracker.findColor(millis());
	TouchList colorTouchs = getTouchListFrom(colorTracker);
	allTouchs.addAll(colorTouchs);   // comment to disable

	// FINGERS
	TouchList fingerTouchs = getTouchListFrom(fingerDetection);
	for(Touch t : fingerTouchs){
	    //	    t.id = 2;
	}
	allTouchs.addAll(fingerTouchs);   // comment to disable

	// Feed the touchs to Skatolo to activate buttons. 
	SkatoloLink.updateTouch(allTouchs, skatolo);
	// Draw the interface
	skatolo.draw(getGraphics());


	// Draw the pointers. (debug)
	drawPointers();
	drawTouch(fingerTouchs);
	
	if(toggle){
	    fill(rectColor);
	    rect(70, 70, 20, 20);
	}
    }

    void drawPointers(){
	for (tech.lity.rea.skatolo.gui.Pointer p : skatolo.getPointerList()) {
	    fill(0, 200, 0);
	    rect(p.getX(), p.getY(), 3,3);
	}
    }

    void drawTouch(TouchList fingerTouchs){
	fill(255, 0, 20);
        for (Touch t : fingerTouchs) {
	    PVector p = t.position;
	    ellipse(p.x, p.y, 10, 10);
	}

    }

    void drawMarkers(TouchList markerTouchs){
	fill(255, 0, 20);
	colorMode(HSB, 10, 100, 100);
        for (Touch t : markerTouchs) {
	    pushMatrix();
	    translate(t.position.x, t.position.y);
	    rotate(t.position.z);
	    fill(t.id, 100, 100);
	    rect(-10, -10, 20, 20);
	    popMatrix();
	}

	colorMode(RGB, 255);
    }

    
}
