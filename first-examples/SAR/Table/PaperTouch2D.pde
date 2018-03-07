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
	ArrayList<TrackedElement> se = stickerTracker.smallElements();
	colorMode(HSB, 5, 100, 100);

	ArrayList<StickerCluster> cluster = stickerTracker.clusters();

	

	for(StickerCluster sc : cluster){

	    PVector p = sc.center;
	    float x = p.x; 
	    float y = p.y; 
	    
	    // TrackedElement f = sc.first;
	    // fill(f.attachedValue, 100, 50);
	    // float x = f.getPosition().x;
	    // float y = f.getPosition().

	    noFill();
	    stroke(1, 100, 50);
	    //	    ellipse(x - 4,y - 4, 8, 8);
	    ellipse(x,
		    y ,
		    40, 40);
	    for(TrackedElement  e: sc){
		noStroke();
		fill(e.attachedValue, 100, 60);
		    ellipse(
			    e.getPosition().x,
			    e.getPosition().y,
			    3, 3);
	    }

	}
	noStroke();
	// for(TrackedElement e : se){

	//     fill(e.attachedValue, 100, 70);
	//     float x = e.getPosition().x;
	//     float y = e.getPosition().y;

	//     ellipse(x ,y , 4, 4);
	// }

	}catch(Exception e){
	    e.printStackTrace();
	}
	// println("Size "  + te.size());
	// captureView();

    }
}
