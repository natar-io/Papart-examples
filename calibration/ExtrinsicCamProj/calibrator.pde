PaperTouchScreen calibrator;

public class MyCalibrator  extends PaperTouchScreen {

    public void settings(){
        setDrawingSize(150, 150);
        loadMarkerBoard(Papart.markerFolder + "calibration-point.svg", 297, 210);
        setDrawOnPaper();
    }

    public void setup() {
	calibrator = this;
	setDrawingFilter(0);
    }

    public void drawOnPaper() {
	background(255);
    }
}
