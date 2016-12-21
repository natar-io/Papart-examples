import fr.inria.papart.multitouch.*;

public class MyApp  extends PaperTouchScreen {

    void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    }

    void setup() {
    }

    void drawOnPaper() {
	if(mouseSetLocation){
	    setLocation(mouseX, mouseY,0 );
	}

	colorMode(RGB, 255);
	background(180, 200);

	fill(200, 100, 20);
	rect(10, 10, 100, 30);

	colorMode(HSB, 20, 100, 100);
	for(Touch touch : touchList){
	    fill(touch.id, 100, 100);
	    ellipse(touch.position.x, touch.position.y, 5, 5);
	}

	float normX = (float) mouseX / (float) width;
	float normY = (float) mouseY / (float) height;
	
	PVector pointer = getDisplay().projectPointer(screen, normX, normY);
	ellipse(pointer.x, pointer.y, 5, 5);
	
    }
}
