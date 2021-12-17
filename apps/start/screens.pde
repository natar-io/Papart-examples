import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;

PVector cardSize = new PVector(56, 82);

PVector infoReaderPosition = new PVector(180, -160);
PVector infoShowPosition = new PVector(infoReaderPosition.x + cardSize.x + 10,
				       infoReaderPosition.y - 80);

PVector plateauPosition = new PVector(-250, -50);
PVector readerPosition = new PVector(plateauPosition.x + 60,
				     plateauPosition.y + 160);


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
	    stickerTracker = new CalibratedStickerTracker(this, 8);
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
	super(infoShowPosition, 200, 160);
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

public class Plateau extends TableScreen{

    Skatolo skatolo;
    
    public Plateau(){
	// Initial location,  width, height.
	super(plateauPosition, 400, 300);
    }
    PImage img;
    PImage img2; 
   boolean toggle;
    public void drawOnPaper() {
	if(img == null){
	    img = loadImage("plateau.png");
	    img2 = loadImage("startflow.png");
	    skatolo = new Skatolo(this.parent, this);
	    skatolo.getMousePointer().disable();
	    skatolo.setAutoDraw(false);
	    skatolo.addHoverToggle("toggle")
		.setPosition(11, drawingSize.y - 82)
		.setSize(20, 20)
		;
	}
	image(img, 0, 0, drawingSize.x, drawingSize.y);

	updateTouch();
	drawTouch();
	
	SkatoloLink.updateTouch(touchList, skatolo);
	skatolo.draw(getGraphics());


	if(toggle){
	    image(img2, 41, drawingSize.y - 13 - 127, 320, 127);
	}
    }
}



public class Reader  extends TableScreen{

    CalibratedStickerTracker stickerTracker;
    
    public Reader(){
	// Initial location,  width, height.
	super(readerPosition, cardSize.x, cardSize.y);
    }

    float count = 0;
    float maxCount = 40;
    boolean valid = false;
    public void drawOnPaper() {
	if(stickerTracker == null){
	    stickerTracker = new CalibratedStickerTracker(this, 9);
	}
	if(valid){
	    background(0, 0, 0);
	    clear();
	    return;
	}
	background(0, 0, 0);
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

	if(foundIDs[1] == 2 && foundIDs[2] == 1){
	    println("count " + count);
	    count++;
	}
	if(count > maxCount){
	    //	    valid = true;
	}
        // drawTouch(15);
    }
}
