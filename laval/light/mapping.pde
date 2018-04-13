import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

public class Mapping  extends PaperTouchScreen {

    public void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
        setDrawAroundPaper();
    }

    PShape model;
    PShader texlightShader;

    public void setup() {
	model = loadShape("catd.obj");
	//	model = loadShape("tinker.obj");
	texlightShader = loadShader("texlightfrag.glsl", "texlightvert.glsl");
    }

    public void drawAroundPaper() {
        background(0);


	// Get the touchInput
	DepthTouchInput touchInput = (DepthTouchInput) getTouchInput();
	touchInput.projectOutsiders(true);
	ArmDetection armDetection = touchInput.getArmDetection();
	ArrayList<TrackedDepthPoint> armPointerTouch = (ArrayList<TrackedDepthPoint>)armDetection.getTipPoints().clone();

	try{

	if(armPointerTouch.size() > 0){
	    Touch t = projectTouch(armPointerTouch.get(0));
	    //	    println(t.position);
	    pushMatrix();
	    translate(t.position.x,
		      -t.position.y + drawingSize.y + 20,
		      -t.position.z);
	    resetShader();
	    noLights();
	    fill(255);
	    ellipse(0, 0, 10, 10);
	    popMatrix();

	    pointLight(255, 255, 255,
		       t.position.x,
		       -t.position.y + drawingSize.y + 20,
		       -t.position.z);

	}
	}catch(Exception e){}
	// Model scale 
	//	scale(100f / 136f);
	 shader(texlightShader);
	// pointLight(255, 255, 255, mouseX, mouseY, 200);
	// ambientLight(128, 255, 128);

	 translate(100, 100,0);
	scale(-1, 1, -1);
	shape(model);

	rect(0, 0, 100, 100);
	
    }
}
