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

	// Uses Papart.colorZoneCalib for tracking parameters. 
	stickerTracker = new CalibratedStickerTracker(this, 15);
    }

    public void drawOnPaper() {
        background(150, 40);

	ArrayList<TrackedElement> stickers = stickerTracker.findColor(millis());
	fill(255);
	noFill();
	stroke(255);
	int size = 12;
	// translate(0, 0, 4); // 3mm up.
	int eSize = 8;
	ellipseMode(CENTER);
	    
	int[] foundIDs = new int[5]; // init 0 by default in java.
	for(TrackedElement s : stickers){
	    
	    noStroke();
	    int c = stickerTracker.getReferenceColor(s.attachedValue);
	    fill(red(c), green(c), blue(c));

	    ellipse(s.getPosition().x,
		    s.getPosition().y,
		    eSize, eSize);

	    noFill();
	    stroke(255);
	    rect(s.getPosition().x - size/2 ,
		 s.getPosition().y -size/2,
	    	 size, size);

	    // text(Integer.toString(s.attachedValue),
	    // 	 s.getPosition().x,
	    // 	 s.getPosition().y - 20);

	    foundIDs[s.attachedValue]++;
	}

	// drawLines();
	drawClusters();
    }



    void drawLines(){
	// Create line clusters.
	ArrayList<LineCluster> lines = stickerTracker.createLineClusters(40);
	noFill();
	colorMode(HSB, lines.size(), 100, 100);
	int k = 0;
	for(LineCluster line : lines){
	    stroke(k++, 100, 100);
	    drawLineBorders(line);	    
	    // drawEachLineComponent(line);
	    // drawOrientation(line);
	}
	colorMode(RGB, 255);
    }

    
    // Cluster drawing
    
    void drawLineBorders(LineCluster line ){
	TrackedElement[] borders = line.getBorders();
	line(borders[0].getPosition().x, borders[0].getPosition().y,
	     borders[1].getPosition().x, borders[1].getPosition().y);
    }

    // Use rotation and translation.
    void drawOrientation(LineCluster line){
	float a = (float) line.angle();
	PVector p = line.position();
	pushMatrix();
	translate(p.x, p.y);
	rotate(a);
	rect(0, 0, 40, 2);
	popMatrix();
    }

    void drawEachLineComponent(LineCluster line){
	PVector previous = null;
	for(TrackedElement s : line){
	    if(previous != null){
		PVector current = s.getPosition();
		line(previous.x, previous.y,
		     current.x, current.y);
	    }
	    previous = s.getPosition();
	}
    }

    void drawClusters(){
	float clusterWidth = 40;
	ArrayList<StickerCluster> clusters = stickerTracker.clusters(clusterWidth);
	colorMode(HSB, clusters.size(), 100, 100);
	int k = 0;
	for(StickerCluster cluster : clusters){
	    fill(k, 100, 100, 20);
	    ellipseMode(CENTER);
	    ellipse(cluster.center.x, cluster.center.y, clusterWidth, clusterWidth);
	    fill(k++, 50, 100);
	    for(TrackedElement s : cluster){
		ellipse(s.getPosition().x, s.getPosition().y, 6, 6);
	    }
	}
	
	colorMode(RGB, 255);
    }
}
