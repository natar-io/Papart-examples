import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;

import tech.lity.rea.colorconverter.*;

import org.openni.*;

import java.util.Arrays;

// EXPERIMENTAL

public class MyApp extends PaperScreen {

    ColorTracker colorTracker;
    CalibratedColorTracker calibratedColorTracker;
    Skatolo skatoloInside;

    int w = 128;
    int h = 128;
    public void settings() {
	setDrawingSize(w, h);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg",
			w, h);
    }

    float sc = 1f;
    
    public void setup() {
		calibratedColorTracker = papart.initAllTracking(this, 1.5f);

	// colorTracker = papart.initRedTracking(this, 1/sc); //0.5f);
	// colorTracker = papart.initBlueTracking(this, 0.5f);
	// colorTracker = papart.initXTracking(this, 1/sc, 4.5f); // 0.5f);
	
	skatoloInside = new Skatolo(parent, this);
	skatoloInside.setAutoDraw(false);
	skatoloInside.getMousePointer().disable();
	
	skatoloInside.addHoverButton("hover")
	    .setPosition(60, 60)
	    .setSize(30, 30);
    }
    
    void hover(){ 
	println("Hover activ");
    }
    
    public void drawOnPaper() {
	try{

	    setLocation(new PVector(40, 40));
	    // println("FrameRate" + frameRate);
	background(200, 100);

	ArrayList<TrackedElement> te = calibratedColorTracker.findColor(millis());
	ArrayList<TrackedElement> te2 = calibratedColorTracker.smallElements();
	TouchList touchs = calibratedColorTracker.getTouchList();
	byte[] found = calibratedColorTracker.getColorFoundArray();
	
	// ArrayList<TrackedElement> te = colorTracker.findColor(millis());
	// TouchList touchs = colorTracker.getTouchList();
	// byte[] found = colorTracker.getColorFoundArray();


	
	// Touch mouse = createTouchFromMouse();
	// touchs.add(mouse);
	noStroke();

	int k = 0;
	pushMatrix();
	fill(20, 255, 10, 180);
	scale(sc);
	colorMode(RGB, 255);
	for(int j = 0; j < drawingSize.y ; j++){

	    for(int i = 0; i < drawingSize.x; i++){

		int offset = j * (int) drawingSize.y + i;
		// if(k >= found.length){
		//     continue;
		// }
		// int v = found[k++];
		int v = found[offset];
		if(v != -1){
		    fill(calibratedColorTracker.getReferenceColor(v));
		    rect(i, j, 2, 2);
		    k++;
		}

		// if(found[k++] == 0){
		//     rect(i, j, 1, 1);
		// }

	    }
	}
	popMatrix();

	for(TrackedElement t : te){
	    fill(200, 150);
	    PVector p = t.getPosition();
	    println("Tracked Element " + p);
	    ellipse(p.x, p.y, 50, 50);
	}

	colorMode(HSB, 8, 1, 1);
	for(TrackedElement t : te2){
	    fill(t.attachedValue, 1, 1);
	    PVector p = t.getPosition();
	    println("Tracked Element2 " + p);
	    ellipse(p.x, p.y, 5, 5);
	}

	SkatoloLink.updateTouch(touchs, skatoloInside); 

	colorMode(RGB, 255);
	
	// println("Number of touchs: " + te.size());
	// Draw the pointers. (debug)
	for (tech.lity.rea.skatolo.gui.Pointer p : skatoloInside.getPointerList()) {
	    // fill(200, 0, 0, 140);
	    // rect(p.getX(), p.getY(), 20, 20);
	}

	// draw the GUI.
	skatoloInside.draw(getGraphics());

	}
	catch(Exception e){
	    e.printStackTrace();
	}

	}
    
}
