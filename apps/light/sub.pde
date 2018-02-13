import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.guimodes.Mode;

boolean subSeen = false;

public class SubApp  extends PaperScreen {

    public void settings(){
	setDrawingSize(shapeSize, shapeSize);
	loadMarkerBoard(sketchPath() + "/markers/sub.svg", shapeSize, shapeSize);
	setDrawAroundPaper();
        setQuality(1.0f);
    }

    public void setup() {
    }
    
    public void drawAroundPaper() {
	//	if(useDebug) setLocation(150, 150, 0);
	// subSeen = getLocationVector().dist(modeLocation) < distMode;

	float x = getLocationVector().x;
	subSeen = x > -centerMode && x < centerMode;
	
	fill(255, 100);
	rect(0, 0, 30, 30);
	//rect(0, 0, drawingSize.x, drawingSize.y);
	
    }
}