import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;



// The table Screen is a PaperTouchScreen that has a position
// relative to the table location.
// The table location is saved when the first pose is saved
// during the calibration process. 
public class MyApp  extends TableScreen{

    public MyApp(){
	// Initial location,  width, height.
	super(-250, -250, 500, 500);
    }
    
    public void drawOnPaper() {
        background(200);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);

	TouchList touchs = getTouchListFrom(fingerDetection);

	fill(255, 0, 20);
        for (Touch t : touchs) {
	    PVector p = t.position;
	    ellipse(p.x, p.y, 10, 10);
	}

    }
}
