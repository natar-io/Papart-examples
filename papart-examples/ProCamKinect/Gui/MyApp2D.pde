import fr.inria.skatolo.*;
import fr.inria.skatolo.events.*;
import fr.inria.skatolo.gui.controllers.*;

import java.util.ArrayList;
import toxi.geom.Vec3D;
import fr.inria.papart.multitouch.*;


public class MyApp  extends PaperTouchScreen {

    Skatolo skatolo;

    void settings() {
        setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
        setQuality(3f);
    }

    void setup() {
	skatolo = new Skatolo(this.parent, this);
	skatolo.getMousePointer().disable();
	skatolo.setAutoDraw(false);

	// skatolo.addSlider("Sliiiide")
	//     .setPosition(0, 0)
	//     .setSize(130, 10)
	//     ;

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
    void button(){
        println("button pressed");
        println("Toggle value " + toggle);
	rectColor += 30;
    }

    float rectColor = 0;
    
    void drawOnPaper(){
	// setLocation(63, 45, 0);
        background(10);
        drawTouch();
        SkatoloLink.updateTouch(touchList, skatolo);
        skatolo.draw(getGraphics());

	if(toggle){
	    fill(rectColor);
	    rect(70, 70, 20, 20);
	}
	
    }

}
