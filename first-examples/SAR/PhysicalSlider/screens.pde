import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;

PVector infoReaderPosition = new PVector(-90, 150 );
PVector infoReaderSize = new PVector(170, 40 );

int lastID = 0;

public class InfoReader  extends TableScreen{

    CalibratedStickerTracker stickerTracker;
    
    public InfoReader(){
	// Initial location,  width, height.
	super(infoReaderPosition, infoReaderSize.x, infoReaderSize.y);
	//	setQuality(2f);

	stickerTracker = new CalibratedStickerTracker(this, 8);
    }
    
    public void drawOnPaper() {
	background(80);
	ArrayList<TrackedElement> stickers = stickerTracker.findColor(millis());
	fill(255);
	noFill();
	stroke(255);
	int size = 12;
	translate(0, 0, 0); // mm up.

	
	int[] foundIDs = new int[5]; // init 0 by default in java.
	
	for(TrackedElement s : stickers){
	    rect(s.getPosition().x - size/2 ,
	    	 s.getPosition().y -size/2,
	    	 size, size);
	    
	    text(Integer.toString(s.attachedValue),
	    	 s.getPosition().x,
	    	 s.getPosition().y - 20);


	    float totalSize = 150f;
	    int nbPos = 9; // 0 to 9
	    float border = (totalSize - infoReaderSize.x) / 2f; 
	    int id = round((s.getPosition().x - border) / totalSize * nbPos);

	    println("ID: "  + id);
	    lastID = id;

	    // TODO: filter to find it X times...
	    //	    foundIDs[s.attachedValue]++;
	}
    }
}


public class IDShow  extends TableScreen{

    public IDShow(){
	super(new PVector(-40, 40), 80, 50);
    }
    
    public void drawOnPaper() {
	background(80);
	text(Integer.toString(lastID), 10, 10);
    }
}
