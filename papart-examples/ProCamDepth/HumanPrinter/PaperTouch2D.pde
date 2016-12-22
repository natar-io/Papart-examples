PaperTouchScreen app;

public class MyApp  extends PaperTouchScreen {

    PImage imageToPrint;
    
    public void settings(){
        setDrawingSize(210, 297);
        loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 210, 297);
        setDrawOnPaper();
    }

    public void setup() {
	app = this;
	imageToPrint = loadImage("marker1515.png");
    }

    public void drawOnPaper() {
        background(40, 40, 40);

	image(imageToPrint,
	      0, 0,
	      drawingSize.x, drawingSize.y);
    }
}
