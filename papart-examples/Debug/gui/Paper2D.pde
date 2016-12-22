import fr.inria.papart.multitouch.*;

import fr.inria.skatolo.*;
import fr.inria.skatolo.events.*;
import fr.inria.skatolo.gui.controllers.*;

public class MyApp  extends PaperTouchScreen {

    Skatolo skatolo;
    
    void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    }

    void setup() {

	// TODO: check this getMousePointer...
	skatolo = new Skatolo(this.parent, this);
	skatolo.getMousePointer().disable();
	skatolo.setAutoDraw(false);

	skatolo.addHoverButton("button")
	    .setPosition(0, 60)
	    .setSize(60, 60)
	    ;
	
	skatolo.addHoverToggle("toggle")
	    .setPosition(100, 60)
	    .setSize(60, 60)
	    ;

    }

    boolean toggle = false;
    float rectColor = 0;
    
    void button(){
        println("button pressed");
        println("Toggle value " + toggle);
	rectColor += 30;
    }

    void drawOnPaper() {
	if(mouseSetLocation){
	    setLocation(mouseX, mouseY,0 );
	}

	colorMode(RGB, 255);
	background(180, 200);

	fill(200, 100, 20);
	rect(10, 10, 100, 30);

	SkatoloLink.addMouseTo(touchList, skatolo, this);
	SkatoloLink.updateTouch(touchList, skatolo);
	skatolo.draw(getGraphics());

	drawTouch();
	
	// colorMode(HSB, 20, 100, 100);
	// for(Touch touch : touchList){
	//     fill(touch.id, 100, 100);
	//     ellipse(touch.position.x, touch.position.y, 5, 5);
	// }

	if(toggle){
	    fill(rectColor);
	    rect(70, 70, 20, 20);
	}
	
	
	
    }
}
