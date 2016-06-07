import fr.inria.papart.procam.ColorDetection;

public class ColorApp extends PaperScreen {

    ColorDetection colorDetection;
    TrackedView boardView;

    // 5cm
    PVector captureSize = new PVector(50, 50);
    PVector origin = new PVector(40, 40);
    int picSize = 64; // Works better with power  of 2

    void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);
    }

    void setup() {
	colorDetection = new ColorDetection((PaperScreen) this);
	colorDetection.setPosition(origin);
	colorDetection.initialize();
    }

    void drawOnPaper() {
        clear();
        setLocation(63, 45, 0);

        colorDetection.computeColor();
        int c = colorDetection.getColor();
        fill(c);
        rect(0, 0, 10, 10);

        colorDetection.drawCaptureZone();

    }
}
