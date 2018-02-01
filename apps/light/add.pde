import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.guimodes.Mode;

boolean saveLocation = false;
PVector modeLocation = new PVector();
boolean addSeen = false;
float distMode = 80;
float centerMode = 70;

public class AddApp  extends PaperScreen {

    public void settings(){
	setDrawingSize(shapeSize, shapeSize);
	loadMarkerBoard(sketchPath() + "/markers/add.svg", shapeSize, shapeSize);
	setDrawAroundPaper();
        setQuality(1.0f);
    }

    public void setup() {
    }
    
    public void drawAroundPaper() {

	if(saveLocation){
	    saveLocation = false;
	    modeLocation.set(getLocationVector());
	}

	// addSeen = getLocationVector().dist(modeLocation) < distMode;

	float x = getLocationVector().x;
	addSeen = x > -centerMode && x < centerMode;
	
	//	if(useDebug) setLocation(150, 150, 0);
	fill(100, 100);
	ellipseMode(CENTER);
	ellipse(0, 0, distMode, distMode);
	rect(0, 0, 30, 30);
	//rect(0, 0, drawingSize.x, drawingSize.y);
	
    }
}
