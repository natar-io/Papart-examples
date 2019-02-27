public class StickerIdentification  extends TableScreen {

    CalibratedStickerTracker stickerTracker;
   
    public StickerIdentification() {
        super(new PVector(-400, 100), 100, 100);
    }

    public void setup() {
        stickerTracker = new CalibratedStickerTracker(this, 8);
        stickerTracker.numberOfRefs = 2;
        stickerTracker.loadDefaultColorReferences();
    }

    int nbFound = 0;
    int maxFound = 10;
    int disappearTimer = 3000;  // ms
    int lastTimeSeen = 0;
    
    public void drawOnPaper() {
        clear();
	findPos();

	
	if(millis() - lastTimeSeen > disappearTimer){
	    nbFound = 0; // never seen 
	}
	
	if(nbFound > maxFound){
	    background(0, 255, 0, 150);
	}else {
	    background(70, 90);
	}
	
    }

    public void findPos(){
        ArrayList<TrackedElement> stickers = stickerTracker.findColor(parent.millis());
        ArrayList<LineCluster> lines = stickerTracker.createLineClusters(50);

        // LineCluster matching = LineCluster.findMatchingLine("RBBRBB", lines);
        LineCluster matching = LineCluster.findMatchingLine("011011", lines);

        if(matching != LineCluster.INVALID_CLUSTER){

	    matching = matching.asCode("011011");

	    System.out.println("Cluster found !");
	    nbFound++;
	    lastTimeSeen = millis();
	    
	    PVector p = matching.getPosition();
	    float angle = (float) matching.angle();

	    pushMatrix();
	    fill(0, 180, 0, 180);
	    translate(p.x, p.y);
	    rotate(angle);
	    rect(-35, -5, 70, 10);
	    popMatrix();

        }	
    }
}



