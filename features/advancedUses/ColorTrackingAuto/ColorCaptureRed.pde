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

    String saveFile = Papart.redThresholds; // local: "data/thresholds.txt";

    // Loaded from calibration
    float threshHue = 0;    // 40
    float threshSat = 0;    // 50 
    float threshIntens = 0; // 90
    float redThresh = 0;  // 30
    int erosionAmount = 1;
    int redColor = 0;

    
    public void settings() {
	setDrawingSize(280, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 280, 210);
    }

    public void setup() {

	loadColorAndThresholds();
	
	// Local calibration-- disabled
	// PlanarTouchCalibration calib = new PlanarTouchCalibration();
	// calib.loadFrom(parent, "TouchColorCalibration.xml");
	// colorTracker = new ColorTracker(this, calib, 1);
	
	// global color tracking configuration 
	colorTracker = new ColorTracker(this, 0.5f);
	colorTracker.setThresholds(threshHue, threshSat, threshIntens);
	colorTracker.setRedThreshold(redThresh);
	
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
	ArrayList<TrackedElement> te = colorTracker.
	    findColor("red", 
		      redColor, 
		      millis(), erosionAmount);
	
	TouchList touchs = colorTracker.getTouchList();
	Touch t = createTouchFromMouse();
	touchs.add(t);
	SkatoloLink.updateTouch(touchs, skatoloInside); 
	
	// Draw the pointers known by skatolo. (debug)
	for (tech.lity.rea.skatolo.gui.Pointer p : skatoloInside.getPointerList()) {
	    fill(0, 200, 0);
	    rect(p.getX(), p.getY(), 3, 3);
	}
	
	skatoloInside.draw(getGraphics());
    }


    
    void loadColorAndThresholds(){
	String[] list = loadStrings(saveFile);
	for(int i = 0; i < list.length; i++){
	    String data = list[i];
	    loadParameter(data);
	}
    }
    
    void loadParameter(String data){
	String[] pair = data.split(":");
	if(pair[0].startsWith("hue")){
	    threshHue = Float.parseFloat(pair[1]);
	}
	if(pair[0].startsWith("sat")){
	    threshSat = Float.parseFloat(pair[1]);
	}
	if(pair[0].startsWith("intens")){
	    threshIntens = Float.parseFloat(pair[1]);
	}
	if(pair[0].startsWith("red")){
	    redThresh = Float.parseFloat(pair[1]);
	}
	if(pair[0].startsWith("erosion")){
	    erosionAmount = Integer.parseInt(pair[1]);
	}
	if(pair[0].startsWith("col")){
	    redColor = Integer.parseInt(pair[1]);
	}
    }
    
    
}
