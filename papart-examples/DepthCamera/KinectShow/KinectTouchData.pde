import fr.inria.papart.depthcam.DepthData;
import fr.inria.papart.depthcam.analysis.*;
import java.util.ArrayList;
import toxi.geom.Vec3D;

public class MyApp extends PaperTouchScreen {

    void settings(){
        setDrawAroundPaper();
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "big-calib.svg", 297, 210);
    }

    void setup() {
    }

    void drawAroundPaper(){
        clear();
        noStroke();

       ArrayList<DepthPoint> points = ((KinectTouchInput) touchInput).projectDepthData3D((ARDisplay ) getDisplay(), screen);

	int k = 0;

	for(DepthPoint depthPoint : points) {
	    PVector pos = depthPoint.getPosition();

	    if(pos.x < 0
	       || pos.x >= drawingSize.x
	       || pos.y < 0
	       || pos.y >= drawingSize.y)
	    	continue;

	    float ellipseSize = 3;
	    int c = depthPoint.getColor();
	    if(c == DepthAnalysis.INVALID_COLOR){
	    	fill(0, 0, 200);
	    } else {
	    	fill(red(c), green(c), blue(c));
	    }

	    pushMatrix();
	    translate(pos.x, pos.y, pos.z);
	    ellipse(0, 0, ellipseSize, ellipseSize);
	    popMatrix();
	}


    }
}
