import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.tracking.*;
 import tech.lity.rea.colorconverter.*;

public class MyApp  extends TableScreen {

    PImage plage;
    TrackedElement trackedPos;
    CalibratedStickerTracker stickerTracker;
   
    public MyApp() {
        super(new PVector(-400, -200), 600, 400);
    }

    public void setup() {
        stickerTracker = new CalibratedStickerTracker(this, 8);
        stickerTracker.numberOfRefs = 2;
        stickerTracker.loadDefaultColorReferences();
        plage = parent.loadImage("plage.png");
        trackedPos = new TrackedElement();
    }

    public void drawOnPaper() {
        background(40, 40, 40);

	findPos();

	translate(trackedPos.getPosition().x, trackedPos.getPosition().y);
        rotate(trackedPos.getPosition().z);
	
        translate(-10, 10);
        fill(255, 200, 10);
        image(plage, 0, 0, 280, 175);
	// image(plage,
	//       0, 0,
	//       drawingSize.x, drawingSize.y);
    }

    public void findPos(){
 background(0, 0, 0);
        ArrayList<TrackedElement> stickers = stickerTracker.findColor(parent.millis());
        ArrayList<LineCluster> lines = stickerTracker.createLineClusters(50);

        ArrayList<PVector> linesPos = new ArrayList();
        ArrayList<String> linesNames = new ArrayList();
	
	linesPos.add(new PVector(00, 00, 0));
        linesNames.add("RBBRBB");
        linesPos.add(new PVector(0, 187, 0));
        linesNames.add("RBBRRB");
        linesPos.add(new PVector(215, 0, 0));
        linesNames.add("RRBBBB");
        linesPos.add(new PVector(215, 187, 0));
        linesNames.add("RRBRRB");

	   PVector corners2 = LineCluster.findRotationTranslationFrom(lines, linesNames, linesPos);

        if (corners2 != LineCluster.INVALID_VECTOR) {
            trackedPos.setPosition(corners2);
        }

        trackedPos.filter(parent.millis());
    }
}
