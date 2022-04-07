import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fr.inria.papart.procam.*; 
import tech.lity.rea.svgextended.*; 
import org.bytedeco.javacpp.*; 
import org.reflections.*; 
import toxi.geom.*; 
import org.openni.*; 
import fr.inria.papart.procam.camera.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ImageExtractionSeeThroughRendering extends PApplet {

// PapARt library







public void settings(){
    size(640, 480, P3D);
}

public void setup(){
    Papart papart = Papart.seeThrough(this);
    new MyApp();
    papart.startTracking();
}

public void draw(){

}


public class MyApp  extends PaperScreen {

    TrackedView boardView;

    // 5cm
    PVector captureSize = new PVector(50, 50);
    PVector origin = new PVector(40, 40);
    int picSize = 64; // Works better with power  of 2

    public void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "calib1.svg", 297, 210);

	// same with setDrawAroundPaper();
	setDrawOnPaper();
    }

    public void setup() {
	boardView = new TrackedView(this);
	boardView.setCaptureSizeMM(captureSize);

	boardView.setImageWidthPx(picSize);
	boardView.setImageHeightPx(picSize);

        boardView.setTopLeftCorner(origin);

	boardView.init();
    }

    // Same with drawAroundPaper().
    public void drawOnPaper() {
        clear();
	//        setLocation(63, 45, 0);

        stroke(100);
        noFill();
        strokeWeight(2);

	line(0, 0, origin.x, origin.y);
	rect((int) origin.x, (int) origin.y,
             (int) captureSize.x, (int)captureSize.y);

        PImage out = boardView.getViewOf(cameraTracking);

	if(out != null){
	    image(out, 120, 40, picSize, picSize);
	}
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ImageExtractionSeeThroughRendering" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
