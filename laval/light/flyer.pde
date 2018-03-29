
PVector cardSize = new PVector(56, 82);

PVector infoReaderPosition = new PVector(180, 100);
PVector infoShowPosition = new PVector(infoReaderPosition.x - 210,
				       infoReaderPosition.y - 145);


float candidateFound = 0;
float zeroImg = 0;
float maxZero = 35;
float maxFound = 35;
   
public class InfoReader  extends TableScreen{

    CalibratedStickerTracker stickerTracker;
    
    public InfoReader(){
	// Initial location,  width, height.
	super(infoReaderPosition, cardSize.x, cardSize.y);
	setQuality(4f);
    }
    
    public void drawOnPaper() {
	if(stickerTracker == null){
	    stickerTracker = new CalibratedStickerTracker(this, 6);
	}
	background(70);
	ArrayList<TrackedElement> stickers = stickerTracker.findColor(millis());
	fill(255);
	noFill();
	stroke(255);
	int size = 12;
	translate(0, 0, 4); // 3mm up.

	if(stickers.isEmpty()){
	    zeroImg++;
	}
	if(zeroImg >= maxZero){
	    candidateFound = 0;
	    zeroImg = 0;
	}
	
	int[] foundIDs = new int[5]; // init 0 by default in java.
	
	for(TrackedElement s : stickers){
	    // rect(s.getPosition().x - size/2 ,
	    // 	 s.getPosition().y -size/2,
	    // 	 size, size);
	    // text(Integer.toString(s.attachedValue),
	    // 	 s.getPosition().x,
	    // 	 s.getPosition().y - 20);
	    
	    foundIDs[s.attachedValue]++;
	}
	
	if(foundIDs[1] == 2 && foundIDs[2] == 1){
	    candidateFound++;
	    zeroImg = 0;
	}

	float amt = constrain(candidateFound / maxFound, 0, 1);
	rect(0, 0,
	     drawingSize.x * amt, 3);
	//        drawTouch(15);
    }
}


public class InfoShow  extends TableScreen{

    public InfoShow(){
	// Initial location,  width, height.
	super(infoShowPosition, 197, 145);
    }
    PImage img;
    
    public void drawOnPaper() {
	if(img == null){
	    img = loadImage("imstart.png");
	}
	if(candidateFound > maxFound){
	    image(img, 0, 0, drawingSize.x, drawingSize.y);
	} else {
	    background(0);
	}
    }
}
