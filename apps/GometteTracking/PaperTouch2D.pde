import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.tracking.*;
 import tech.lity.rea.colorconverter.*;
import redis.clients.jedis.BinaryJedisPubSub;


public class MultiStickerTracker  extends TableScreen {

    PImage plage;
    TrackedElement trackedPos;
    CalibratedStickerTracker stickerTracker;
   
    public MultiStickerTracker() {
        super(new PVector(-400, -200), 600, 300);
    }

    public void setup() {
        stickerTracker = new CalibratedStickerTracker(this, 8);
        stickerTracker.numberOfRefs = 2;
        stickerTracker.loadDefaultColorReferences();
        plage = parent.loadImage("plage.png");
        trackedPos = new TrackedElement();
	trackedPos.setPosition(new PVector(-100, -100, 0));
    }

    public void drawOnPaper() {
        clear();
	background(70, 90);
	findPos();

	translate(trackedPos.getPosition().x, trackedPos.getPosition().y);
        rotate(trackedPos.getPosition().z);
        translate(-10, 10);
        fill(255, 200, 10);
	image(plage, 0, 0, 280, 175);

    }

    public void findPos(){

	// println("Framerate " + frameRate);
        ArrayList<TrackedElement> stickers = stickerTracker.findColor(parent.millis());
        ArrayList<LineCluster> lines = stickerTracker.createLineClusters(50);

        ArrayList<PVector> linesPos = new ArrayList();
        ArrayList<String> linesNames = new ArrayList();

	
	linesPos.add(new PVector(0, 0, 0));
        linesNames.add("RBBRBB");
        linesPos.add(new PVector(0, 187, 0));
        linesNames.add("RBBRRB");
        linesPos.add(new PVector(215, 0, 0));
        linesNames.add("RRBBBB");
        linesPos.add(new PVector(215, 187, 0));
        linesNames.add("RRBRRB");

	PVector corners2 = LineCluster.findRotationTranslationFrom(lines, linesNames, linesPos);


	PVector previous = trackedPos.getPosition();
	// if(previous.dist(corners2) < 3){
 	//     println("dist" + previous.dist(corners2));
	//     return;
	// }
        if (corners2 != LineCluster.INVALID_VECTOR) {
            trackedPos.setPosition(corners2);
        }
	
	trackedPos.filter(parent.millis());
    }
}



