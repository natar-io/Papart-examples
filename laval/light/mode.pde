import fr.inria.papart.tracking.DetectedMarker;
import java.util.Arrays;

PVector modesZonePos = new PVector(-130, 155);
PVector modesZoneSize = new PVector(180, 40);

PVector plateauPosition = new PVector(-350, -250);

public class ModesZone  extends TableScreen {

    //    ColorTracker colorTracker;
    Skatolo skatoloInside;
    
    public ModesZone(){
	super(modesZonePos, modesZoneSize.x, modesZoneSize.y);
	init();
    }

    public void init() {
	//	colorTracker = papart.initRedTracking(this, 1f);
	skatoloInside = new Skatolo(parent, this);
	skatoloInside.setAutoDraw(false);
	skatoloInside.getMousePointer().disable();
	
	int initP = 10;
	int gap = 70;
	skatoloInside.addHoverButton("add")
	    .setPosition(initP, 10)
	    .setSize(20, 20)
	    .setLabelVisible(false);
	
	skatoloInside.addHoverButton("subtract")
	    .setPosition(initP + gap, 10)
	    .setSize(20, 20)
	    .setLabelVisible(false);
	
	skatoloInside.addHoverButton("normal")
	    .setPosition(initP + gap * 2, 10)
	    .setSize(20, 20)
	    .setLabelVisible(false);
    }

    void add(){
	Mode.set("add");
    }
    void subtract(){
	Mode.set("subtract");
    }
    void normal(){
	Mode.set("normal");
    }
    
    boolean debug = false;

    
    public void drawOnPaper() {
	//      setLocation(0, drawingSize.y, 0);
	background(80);
      
	updateTouch();
	// ArrayList<TrackedElement> te = colorTracker.findColor(millis());
	// TouchList touchs = colorTracker.getTouchList();

	SkatoloLink.updateTouch(touchList, skatoloInside); 


	for (tech.lity.rea.skatolo.gui.Pointer p : skatoloInside.getPointerList()) {
	    fill(0, 200, 0);
	    rect(p.getX(), p.getY(), 3, 3);
	}

	skatoloInside.draw(getGraphics());
    }
}



float MARKER_WIDTH = 44f;

int red = 335;
int cyan = 336;
int green = 337;
int magenta = 338;
int blue = 339;
int yellow = 340;

int filterPerColor = 3;
int nbColors = 6;

int lastColorSeen[] = new int[nbColors];
boolean filtered[] = new boolean[nbColors];

public boolean isColor(int id){
    return id >= red && id <= yellow;
}


public class Plateau extends TableScreen{

    Skatolo skatolo;

    public Plateau(){
	// Initial location,  width, height.
	super(plateauPosition, 650, 400);
	initTouchListFromMarkers(red, yellow, 25, true);
    }

    public void drawOnPaper() {
	background(0);
	// Marker tracker


	
	noFill();
	stroke(200);
	rect(1, 1, drawingSize.x-1, drawingSize.y-1);

	// TODO: skatolo to fix the positions ?!!
	
	if(Mode.is("add")){
	    blendMode(ADD);
	    background(0);
	}
	if(Mode.is("subtract")){
	    blendMode(SUBTRACT);
	    background(255);
	}

	if(Mode.is("normal")){
	    blendMode(BLEND);
	}
	
	drawColors();
    }

    int REMOVE_DUR = 1000;
    
    void drawColors(){

	TouchList markerTouchs = getTouchListFromMarkers();
	//	drawMarkers(markerTouchs);
	// allTouchs.addAll(markerTouchs);  // comment to disable

	for(Touch t : markerTouchs){

	    PVector pos = t.position;
	    int id = t.id;
	    
	    pushMatrix();
	    translate(pos.x, pos.y);
	    rotate(pos.z);
	    translate(60, 20);
	    if(id == red){
		fill(255, 0, 0);
	    }
	    if(id == blue){
		fill(0, 0, 255);
	    }
	    if(id == green){
		fill(0, 255, 0);
	    }
	    if(id == cyan){
		fill(0, 255, 255);
	    }
	    if(id == magenta){
		fill(255, 0, 255);
	    }
	    if(id == yellow){
		fill(255, 255, 0);
	    }
	    ellipse(0, 0, 70, 70);			
	    popMatrix();
	    
	}
    }

    
}
