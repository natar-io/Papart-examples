import fr.inria.papart.multitouch.*;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

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

	// Local Touch - Warning 3334 instead of 3333
	connectLocalTUIO(3334);
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

	TouchList tuioTouch = getLocalTUIOTouchList();
	TouchList tuioTouch2 = getTouchList(touchInputTuio);

	tuioTouch.addAll(tuioTouch2);
	
	SkatoloLink.addMouseTo(tuioTouch, skatolo, this);
	SkatoloLink.updateTouch(tuioTouch, skatolo);
	skatolo.draw(getGraphics());

	colorMode(HSB, 20, 100, 100);
	for(Touch touch : tuioTouch){


	    int size = 10;
	    if(tuioTouch2.contains(touch)){
		size= 15;
	    }
	    fill(touch.id, 100, 100);
	    stroke(255);
	    ellipse(touch.position.x,
		    touch.position.y, size, size);
	}

	if(toggle){
	    fill(rectColor);
	    rect(70, 70, 20, 20);
	}
	
	
	
    }
}
