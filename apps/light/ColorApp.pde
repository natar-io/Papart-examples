//float shapeSize = 150;

public class ColorApp extends PaperScreen{

    PVector debugPosition = new PVector();
    int c; 
    String marker;
    
    public ColorApp(String marker, int debugX, int debugY, int col){
	super();
	this.c = col;
	this.marker = marker;
	debugPosition.set(debugX, debugY);
    }

    public void settings(){
        setDrawingSize(shapeSize, shapeSize);
        loadMarkerBoard(sketchPath() + "/markers/" + marker, shapeSize, shapeSize);
        setDrawAroundPaper();
        setQuality(1.0f);
    }

    public void setup() {
    }
    
    public void drawAroundPaper() {
	drawOnTable();
	if(useDebug) setLocation(debugPosition.x, debugPosition.y, 0);
	fill(c);
	translate(shapeSize / 2, shapeSize/2);
	ellipse(0, 0, shapeSize, shapeSize);
    }
}

