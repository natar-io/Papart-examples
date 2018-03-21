import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;
import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;


import fr.inria.guimodes.Mode;

public class BlueApp  extends PaperScreen {

    public void settings(){
        setDrawingSize(shapeSize, shapeSize);
	loadMarkerBoard(sketchPath() + "/markers/bleu.svg", shapeSize, shapeSize);
	setDrawAroundPaper();

        setQuality(1.0f);
    }

    public void setup() {
    }
    
    public void drawAroundPaper() {
	// Experimental, only in DrawAroundPaperMode
  // 	drawOnTable();
	
  // 	if(Mode.is("add")){
  // 	    blendMode(ADD);
  // 	    background(0);
  // 	}
  // 	if(Mode.is("subtract")){
  // 	    blendMode(SUBTRACT);
  // 	    background(255);
  // 	}

  // 	if(Mode.is("normal")){
  // 	    blendMode(BLEND);
  // 	}
	
  // 	// if(useDebug) setLocation(mouseX, mouseY, 0);

  // 	fill(0, 0, 255);
  // translate(shapeSize / 2, shapeSize/2);
  // ellipse(0, 0, shapeSize, shapeSize);
  // 	//rect(0, 0, drawingSize.x, drawingSize.y);
	
    }
}
