import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

import tech.lity.rea.colorconverter.*;

import java.util.ArrayList;
import toxi.geom.Vec3D;



public class MyApp  extends PaperTouchScreen {

    Skatolo skatolo;
   ColorTracker colorTracker;
    
    void settings() {
        setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
	//        setQuality(1f);
    }

    void setup() {

		// colorTracker = papart.initRedTracking(this, 1f);
	colorTracker = papart.initBlueTracking(this, 1f);
	
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
	updateTouch();


	// COLOR
	ArrayList<TrackedElement> te = colorTracker.findColor(millis());
	TouchList touchs = colorTracker.getTouchList();
	SkatoloLink.updateTouch(touchs, skatolo); 

	// MOUSE
	//	SkatoloLink.addMouseTo(touchList, skatolo, this);

	// FINGERS
	//	SkatoloLink.updateTouch(touchList, skatolo);

	//        drawTouch();
	skatolo.draw(getGraphics());

	if(toggle){
	    fill(rectColor);
	    rect(70, 70, 20, 20);
	}
	
    }

}
