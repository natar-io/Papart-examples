import fr.inria.papart.procam.ColorDetection;

public class ColorApp extends PaperScreen {

    ColorDetection colorDetection;
    TrackedView boardView;

    // 5cm
    PVector captureSize = new PVector(10, 10);
    PVector origin = new PVector(0, 0);
    int picSize = 64; // Works better with power  of 2

    void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    }

    void setup() {
	colorDetection = new ColorDetection((PaperScreen) this);
	colorDetection.setPosition(origin);
	colorDetection.setCaptureSize(captureSize);
	colorDetection.setPicSize(picSize, picSize);
	colorDetection.initialize();
    }

    void drawOnPaper() {
        clear();

	//	setLocation(10, 0, 0);

	
        colorDetection.computeColor();
        int c = colorDetection.getColor();
        fill(c);
	//         rect(0, 0, 10, 10);
	//        colorDetection.drawCaptureZone();

	colorDetection.drawSelf();
	
    }
}
