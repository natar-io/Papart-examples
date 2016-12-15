import fr.inria.papart.procam.ColorDetection;

public class ColorApp extends PaperScreen {

    ColorDetection colorDetection;
    TrackedView boardView;

    // 5cm
    PVector captureSize = new PVector(25, 25);
    PVector origin = new PVector(100, 100);
    int picSize = 128; // Works better with power  of 2

    void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
	setDrawAroundPaper();
    }

    void setup() {
	colorDetection = new ColorDetection((PaperScreen) this);
	colorDetection.setPosition(origin);
	colorDetection.setCaptureSize(captureSize);
	colorDetection.setPicSize(picSize, picSize);
	
	colorDetection.initialize();
    }

    //    void drawOnPaper() {
    void drawAroundPaper() {
        clear();
	rect(0, 0, 80, 20);
	// setLocation(63, 45, 0);

	if(saveColor){
	    colorDetection.computeColor();
	    diceColor = colorDetection.getColor();
	    saveColor = false;
	}
	int nbBlack = colorDetection.computeOccurencesOfColor(diceColor,
							      20);
	colorDetection.drawSelf();
    }

    boolean saveColor = false;
    int diceColor = 0;
    
    void keyPressed(){
	if(key == 'c'){
	    saveColor = true;
	}
    }
}
