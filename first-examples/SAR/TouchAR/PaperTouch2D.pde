PaperTouchScreen app;

public class MyApp  extends PaperTouchScreen {

    public void settings(){
        setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
        setDrawOnPaper();
    }

    public void setup() {
	app = this;
    }

    public void drawOnPaper() {
        background(0);

	noFill();
	stroke(255);
	rect(0, 0, drawingSize.x, drawingSize.y);

	fill(200, 100, 20);
	rect(10, 10, 100, 30);

	TouchList touchs = getTouchListFrom(fingerDetection);

	fill(255, 0, 20);
        for (Touch t : touchs) {
	    PVector p = t.position;
	    ellipse(p.x, p.y, 10, 10);
	}
    }
}
