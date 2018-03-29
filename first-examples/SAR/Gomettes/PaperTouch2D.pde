import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;


public class MyApp  extends PaperTouchScreen {
    CalibratedStickerTracker stickerTracker;
    
    public void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
        setDrawOnPaper();
    }
    
    public void setup() {
	stickerTracker = new CalibratedStickerTracker(this, 8);
    }

    public void drawOnPaper() {
        background(40, 40, 40);

	ArrayList<TrackedElement> stickers = stickerTracker.findColor(millis());
	fill(255);
	noFill();
	stroke(255);
	int size = 12;
	translate(0, 0, 4); // 3mm up.
	
	int[] foundIDs = new int[5]; // init 0 by default in java.
		for(TrackedElement s : stickers){
	    rect(s.getPosition().x - size/2 ,
	    	 s.getPosition().y -size/2,
	    	 size, size);
	    text(Integer.toString(s.attachedValue),
	    	 s.getPosition().x,
	    	 s.getPosition().y - 20);
	    
	    foundIDs[s.attachedValue]++;
	}
	
        // fill(200, 100, 20);
        // rect(10, 10, 100, 30);
        // drawTouch(15);
    }
}
