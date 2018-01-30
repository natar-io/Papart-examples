import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;

import org.openni.*;

import java.util.Arrays;

// EXPERIMENTAL

public class MyApp extends PaperScreen {

    ColorTracker colorTracker;
    CalibratedColorTracker calibratedColorTracker;
    Skatolo skatoloInside;

    int w = 256;
    int h = 256;
    public void settings() {
	setDrawingSize(w, h);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg",
			w, h);
    }

    float sc = 1f;
    
    public void setup() {
		calibratedColorTracker = papart.initAllTracking(this, 1f/sc);

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
    
    void hover() {
	println("Hover activ");
    }
    
    public void drawOnPaper() {
	try{
	// println("FrameRate" + frameRate);
	background(200, 100);

	ArrayList<TrackedElement> te = calibratedColorTracker.findColor(millis());
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
	
	for(int j = 0; j < drawingSize.y / sc; j++){
	    for(int i = 0; i < drawingSize.x / sc; i++){

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
	    fill(t.attachedValue, 100, 100);
	    PVector p = t.getPosition();
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
