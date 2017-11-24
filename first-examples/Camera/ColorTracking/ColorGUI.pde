import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.calibration.files.*;

import java.util.Arrays;

public class MyApp extends PaperScreen {

    ColorTracker colorTracker;
    Skatolo skatoloInside;
    
    public void settings() {
	setDrawingSize(280, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 280, 210);
    }

    public void setup() {

	colorTracker = papart.initRedTracking(this, 0.5f);
	// colorTracker = papart.initBlueTracking(this, 0.5f);

	skatoloInside = new Skatolo(parent, this);
	skatoloInside.setAutoDraw(false);
	skatoloInside.getMousePointer().disable();
	
	skatoloInside.addHoverButton("hover")
	    .setPosition(120, 120)
	    .setSize(30, 30);
    }
    
    void hover() {
	println("Hover activ");
    }
    
    public void drawOnPaper() {
	background(200, 100);

	ArrayList<TrackedElement> te = colorTracker.findColor(millis());
	TouchList touchs = colorTracker.getTouchList();
	Touch mouse = createTouchFromMouse();
	touchs.add(mouse);

	SkatoloLink.updateTouch(touchs, skatoloInside); 
	
	// Draw the pointers. (debug)
	for (tech.lity.rea.skatolo.gui.Pointer p : skatoloInside.getPointerList()) {
	    fill(0, 200, 0);
	    rect(p.getX(), p.getY(), 3, 3);
	}

	// draw the GUI.
	skatoloInside.draw(getGraphics());
    }
    
}
