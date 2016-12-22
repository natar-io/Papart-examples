//  http://artoolkit.org/documentation/doku.php?id=3_Marker_Training:marker_multi
import fr.inria.papart.procam.ColorDetection;

public class MyApp extends PaperScreen {

    public void settings() {
	setDrawingSize(297, 210);
	try{
	    loadMarkerBoard(sketchPath() + "/markers/cube.cfg", 297, 210);
	    // 3D view
	    setDrawAroundPaper();
	} catch(Exception e){
	    e.printStackTrace();
	}
    }
    
    public void setup() {

    }

    public void drawAroundPaper() {
	clear();
	setLocation(0, 0, 0);

	stroke(100);
	noFill();
	strokeWeight(2);
    
	// For a 60mm cube (6cm) 
	// box(60);

	rectMode(CENTER);
	
	// our cube is inside...

	// Face with Marker #100
	fill(200, 0, 0, 100);
	drawFace();

	PMatrix3D mat = new PMatrix3D(1, 0, 0, 0,
				      0, 1, 0, 0,
				      0, 0, 1, 0,
				      0, 0, 0, 0);

	// ToARToolkit example for Marker #101
	// mat.rotateX(-HALF_PI);
	// mat.translate(0, 30, 30);
	// mat.print();

       	// println("Marker104");  ## also OK
	// mat.rotateX(-HALF_PI);
	// mat.translate(0, 30, -30);
	// mat.scale(1, -1, -1);
	// mat.print();

	
	
	// Face with Marker #101
	pushMatrix();

	// To match with ARToolkitplus
	scale(1, -1, 1);

	rotateX(-HALF_PI);
	translate(0, 30, 30);

	//-off- To match with ARToolkitplus
	scale(1, -1, 1);
	fill(20, 20, 200, 100);
	drawFace();
	popMatrix();
	

	
	// // Marker #102
	// mat.translate(30, 30);
	// mat.scale(1, -1, -1);
	// mat.rotateY(-HALF_PI);
	// mat.translate(-60, 0, 0);
	// mat.translate(-30, -30);
	// mat.print();

	
	// Face with Marker #102  ## Not working
	pushMatrix();
	scale(1, -1, 1);

	translate(30, 0, -30);
        rotateY(HALF_PI);
	scale(1, 1, -1);

	scale(1, -1, 1);
	fill(20, 200, 20, 100);
	drawFace();
	popMatrix();

	// mat.translate(30, 0, -30);
	// mat.rotateZ(-HALF_PI);
	// mat.print();

	

	// Face with Marker #103
	pushMatrix();
	// To match with ARToolkitplus
	scale(1, -1, 1);
	translate(0, 0, -60);
	scale(1, -1, -1);
	// To match with ARToolkitplus
	scale(1, -1, 1);

	fill(250, 140, 20, 100);
	drawFace();
	popMatrix();

	// Face with Marker #104
	pushMatrix();
	scale(1, -1, 1);

	rotateX(-HALF_PI);
	translate(0, 30, -30);
	scale(1, -1, -1);
	
	scale(1, -1, 1);
	fill(20, 140, 120, 100);
	drawFace();
	popMatrix();

	// // Face with Marker #105  ## not working
	// pushMatrix();
	// //	translate(0, 0, 60);
	// rotateY(HALF_PI);
	// translate(0, 0, 60);
	// fill(120, 200, 120, 100);
	// drawFace();
	// popMatrix();

	
	//	translate

	// translate(0, 0, 0);
	// drawFace();

    }
    
    
    public void drawFace(){
	pushMatrix();
	stroke(0);
	strokeWeight(1);
	rect(0, 0, 60,60);
	translate(0, 0, 1);
	rect(0, 0, 40, 40);

	translate(10, 5);
	rect(0, 0, 5, 5);
	
	popMatrix();
    }
	
}
