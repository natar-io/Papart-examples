PaperTouchScreen app;

public class MyApp  extends PaperTouchScreen {

    public void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A4-calib.svg", 297, 210);
        setDrawOnPaper();
    }

    public void setup() {
	app = this;
    }

    public void drawOnPaper() {
        background(255);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);
        drawTouch(15);
    }
}