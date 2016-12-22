
public class Printed  extends PaperTouchScreen {

    
    public void settings(){
        setDrawingSize(210, 297);
        loadMarkerBoard(sketchPath() + "/data/marker1515.svg", 210, 297);
        setDrawOnPaper();
    }

    public void setup() {
	// imageToPrint = loadImage("marker1515.png");
    }

    public void drawOnPaper() {
        background(40, 40, 40);

	fill(200);
	rect(0, 0, 100, 100);
	
	// image(imageToPrint,
	//       0, 0,
	//       drawingSize.x, drawingSize.y);
    }
}
