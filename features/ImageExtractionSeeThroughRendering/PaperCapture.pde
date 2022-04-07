import fr.inria.papart.procam.camera.*;

public class MyApp  extends PaperScreen {

    TrackedView boardView;

    // 5cm
    PVector captureSize = new PVector(50, 50);
    PVector origin = new PVector(40, 40);
    int picSize = 64; // Works better with power  of 2

    void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "calib1.svg", 297, 210);

	// same with setDrawAroundPaper();
	setDrawOnPaper();
    }

    void setup() {
	boardView = new TrackedView(this);
	boardView.setCaptureSizeMM(captureSize);

	boardView.setImageWidthPx(picSize);
	boardView.setImageHeightPx(picSize);

        boardView.setTopLeftCorner(origin);

	boardView.init();
    }

    // Same with drawAroundPaper().
    void drawOnPaper() {
        clear();
	//        setLocation(63, 45, 0);

        stroke(100);
        noFill();
        strokeWeight(2);

	line(0, 0, origin.x, origin.y);
	rect((int) origin.x, (int) origin.y,
             (int) captureSize.x, (int)captureSize.y);

        PImage out = boardView.getViewOf(cameraTracking);

	if(out != null){
	    image(out, 120, 40, picSize, picSize);
	}
    }
}
