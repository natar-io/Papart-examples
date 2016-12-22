public class MyApp  extends PaperTouchScreen {

    public void settings(){
        setDrawingSize(100, 50);
        loadMarkerBoard(sketchPath() + "/ExtractedView.bmp", 162, 104);
	// loadMarkerBoard(sketchPath() + "/ExtractedView.bmp", 90, 50);
	setDrawOnPaper();
    }

    public void setup() {

    }

    public void drawOnPaper() {
        setLocation(170, 0, 0);
	background(40, 40, 40);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);
        drawTouch(15);
    }
}
