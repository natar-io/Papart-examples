import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;

public class MyApp  extends MainScreen {

    public void drawOnPaper() {

	// LineCluster.epsilon = (float) mouseX / 100f;
	// println(LineCluster.epsilon);
        background(0);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);
        drawTouch(15);
	try{
	ArrayList<TrackedElement> te = stickerTracker.findColor(millis());
	fill(89);
	ArrayList<TrackedElement> se = stickerTracker.smallElements();
	colorMode(HSB, 5, 100, 100);

	ArrayList<LineCluster> cluster = stickerTracker.lineClusters();

	stroke(3, 10, 20);
	//	fill(3, 100, 100);
	
	//	println("cluster size " + cluster.size());
	int k = 0;
	for(LineCluster l : cluster){
	    PVector p = l.position();

	    // matching point highlight
	    for(LineCluster l2 : cluster){
	        if(l == l2){
		    continue;
		}
		for(TrackedElement t2 : l){
		    for(TrackedElement t1 : l2){
			if(t2 == t1){
			    fill(0, 100, 100);
			    float x = t1.getPosition().x;
			    float y = t1.getPosition().y;
			    ellipse(x,y , 10, 10);
			}
		    }
		}
		    
	    }
	    
	    // println("s: " + l.size() + " " + l.angle());

	    pushMatrix();
	    translate(p.x, p.y);
	    fill(1, 20, 20);
	    text(l.size(), 40, 0);
	    noFill();
	    float s = l.size() * 15;
	    rotate((float) l.angle());
	    rect(-s / 2, -10, s, 20);
	    //	    rect(0, 0, (float) l.e0, (float) l.e1);
	    popMatrix();

	    for(TrackedElement e : l){
		fill(k, 100, 40);
		float x = e.getPosition().x;
		float y = e.getPosition().y;
		ellipse(x,y , 4, 4);
	    }
	    k++;
	    
	}
	
	
	// ArrayList<StickerCluster> cluster = stickerTracker.clusters();
	// for(StickerCluster sc : cluster){
	//     // sc.analyse();
	//     PVector p = sc.center;
	//     float x = p.x; 
	//     float y = p.y; 
	//     stroke(1, 100, 100);
	//     strokeWeight(1);
	//     noFill();
	//     stroke(1, 100, 50);
	//     //	    ellipse(x - 4,y - 4, 8, 8);
	//     ellipse(x,
	// 	    y ,
	// 	    40, 40);
	//     for(TrackedElement  e: sc){
	// 	noStroke();
	// 	fill(e.attachedValue, 100, 60);
	// 	    ellipse(
	// 		    e.getPosition().x,
	// 		    e.getPosition().y,
	// 		    3, 3);
	//     }

	// }
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
