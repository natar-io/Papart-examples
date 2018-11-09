import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;

// The table Screen is a PaperTouchScreen that has a position
// relative to the table location.
// The table location is saved when the first pose is saved
// during the calibration process. 
public class MyApp  extends TableScreen{

    // Intensité du flou
    float bgAlpha = 10;
    
    // Vitesse de rotation
    float bgRot = 100; 
    
    public MyApp(){
	// Initial location,  width, height.
	super(-200, -200, 400f, 400f);
    }

    void setup(){
    
    }

    boolean isStars = true;
    
    public void drawOnPaper() {

	//    blendMode(BLEND);
	colorMode(HSB, 360, 100, 100, 100);
	noStroke();


	DepthTouchInput touchInput = (DepthTouchInput) getTouchInput();
	
	FingerDetection fingerDetection = touchInput.getFingerDetection();
	HandDetection handDetection = touchInput.getHandDetection();
	ArmDetection armDetection = touchInput.getArmDetection();


	ArrayList<TrackedDepthPoint> handTouch = new ArrayList((ArrayList<TrackedDepthPoint>)armDetection.getTouchPoints());

	PVector hand = new PVector(drawingSize.x / 2, drawingSize.y / 2, 50);


	if(isStars){
	    background(0);
	    isStars = false;
	}

	for(TrackedDepthPoint tp : handTouch){
	    isStars = true;
	    hand = tp.getPosition();
	    hand.x =  hand.x * drawingSize.x;
	    hand.y =  hand.y * drawingSize.y;

	    pushMatrix();



	    translate(hand.x, hand.y);
	    // rotation -> 
	    rotate(frameCount / bgRot);


	    int nbStars = 12;
	    for (int d = 0; d < nbStars; d++) {
	    
		rotate(radians(30));
		fill(d * 30, 100, 100, 40);
		//	blendMode(SCREEN);
	
		drawStar(d, hand);
	    }
	    popMatrix();
	}
    }
    


     
void drawStar(int d, PVector obj) {
    pushMatrix();
    //    translate(obj.x, obj.y);

    
    translate(100 - obj.z,
	      100 - obj.z);


    // Distance au centre 
    // translate(mouseX - width / 2,
    // 	      mouseY - height /2);

    float rotVec;
    if ((d % 2) != 0) {
        rotVec = 1;
    } else {
        rotVec = -1;
    }

    // Etoile sur elle même 
    rotate(frameCount / 1000 * rotVec);

    // Taille d'etoile 
    scale(1);

    // Dessin de l'étoile

    //    rect(0, 0, 10, 10);
    drawSingleStar();


    // for (let i = 0; i < obj.ptArr.length; i++) {
    //     vertex(obj.ptArr.get(i).x, obj.ptArr.get(j).y);
    // }
    // endShape();
    popMatrix();
}

void drawSingleStar(){

    beginShape();
    for (int i = 0; i < 360; i += 36) {
	float ptflg;

	// float x = 0;
	// float y = 0;
	float rad = 15;
	float scale = 1;
	float speed = 1000;
	

	if ((i % 72) != 0) {
	    ptflg = .38;
	} else {
	    ptflg = 1;
	}

	vertex(cos(radians(i)) * rad * ptflg,
	       sin(radians(i)) * rad * ptflg);
    }
    endShape();    
}

}
