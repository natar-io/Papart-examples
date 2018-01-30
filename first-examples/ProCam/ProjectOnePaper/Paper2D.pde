MyApp app;

public class MyApp  extends PaperScreen {

    public void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + calibrationFileName, 162, 104);
			//297, 210);
        setDrawOnPaper();

	// Test: no filtering with this tracker. 
        getMarkerBoard().removeFiltering(cameraTracking);
	app = this;
    }

    public void setup() {
    }

    public void drawOnPaper() {

	background(40, 40, 40);
        // fill(200, 100, 20);

        // rect(10, 10, 100, 30);

	// fill the next shapes with green
	fill(0, 100, 0, 100);
	rect(0, 0, 100, 100);
	
	noStroke();
	// draw a green rectangle
	rect(97.7f, 140, 101, 12);
    }
}
