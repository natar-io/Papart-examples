
import redis.clients.jedis.*;
PaperTouchScreen app;

public class MyApp  extends PaperTouchScreen {

    PImage imageToPrint;
    
    public void settings(){
        setDrawingSize(297, 210);
    //    loadMarkerBoard(Papart.markerFolder + "A4-default-aruco.svg", 297, 210);
	 loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
        setDrawOnPaper();
	setDrawingFilter(0);
    }

    public void setup() {
	app = this;
	//	imageToPrint = loadImage("marker1515.png");
	imageToPrint = loadImage("plage.png");
    }

    public void drawOnPaper() {
        background(40, 40, 40);
	setLocation(0, 0, 0);
	image(imageToPrint,
	      0, 0,
	      drawingSize.x, drawingSize.y);
    }
}
