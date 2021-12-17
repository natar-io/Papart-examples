import fr.inria.papart.procam.camera.*;
import redis.clients.jedis.Jedis;

public class MyApp  extends TableScreen {

    public MyApp(){
	super(new PVector(0, 0) , 400, 400);
    }
    
    TrackedView boardView;

    PVector captureSize = new PVector(700, 500);

    int picSize = 100; // Works better with power  of 2

    Jedis redis;
    // void settings(){
    // 	setDrawingSize(297, 210);
    // 	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);

    // 	// same with setDrawAroundPaper();
    // 	setDrawOnPaper();
    // }

    void setup() {
	// boardView = new TrackedView(this);
	// boardView.setCaptureSizeMM(captureSize);
	// boardView.setScale(1f);
	// // boardView.setImageWidthPx((int) (px));
	// // boardView.setImageHeightPx((int) (hx));

	PVector origin = new PVector(-700/2, 350/2);
	// // boardView.setTopLeftCorner(origin);
	// boardView.setBottomLeftCorner(origin);

	// boardView.init();

	boardView = new TrackedView(this);
	boardView.setCaptureSizeMM(captureSize);

	boardView.setImageWidthPx(700);
	boardView.setImageHeightPx(500);

        // boardView.setBottomLeftCorner(origin);
	        boardView.setTopLeftCorner(origin);
	boardView.init();
	
	redis = new Jedis("localhost",6379);
 
    }

    // Same with drawAroundPaper().
    void drawOnPaper() {
        clear();
	//        setLocation(63, 45, 0);
	background(200, 100);
        stroke(100);
        noFill();
        strokeWeight(2);

	// line(0, 0, origin.x, origin.y);
	// rect((int) origin.x, (int) origin.y,
        //      (int) captureSize.x, (int)captureSize.y);

        PImage out = boardView.getViewOf(cameraTracking);
	boardView.sendImage(getCameraTracking(), redis, "camera0:view1", true, true);
	if(out != null){
	    image(out, 0, 0, 200, 200);
	    // image(out, 120, 40, picSize, picSize);
	}
    }
}
