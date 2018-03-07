import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;

public class MyApp  extends MainScreen {

    public void drawOnPaper() {
        background(0);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);
        drawTouch(15);
	try{
	ArrayList<TrackedElement> te = stickerTracker.findColor(millis());
	fill(89);

	colorMode(HSB, 5, 100, 100);
	
	for(TrackedElement e : te){
	    fill(e.attachedValue, 100, 30);
	    float x = e.getPosition().x / 5f * 8f / stickerTracker.bias;
	    float y = e.getPosition().y / 5f * 8f / stickerTracker.bias;

	    ellipse(x,y, 5, 5);
	}

	}catch(Exception e){
	    e.printStackTrace();
	}
	// println("Size "  + te.size());
	// captureView();
	if(test) {
	    cap = true;
	    test = false;
	}
    }
}
