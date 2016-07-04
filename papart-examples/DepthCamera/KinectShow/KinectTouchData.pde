import fr.inria.papart.depthcam.DepthData;
import fr.inria.papart.depthcam.analysis.*;
import java.util.ArrayList;
import toxi.geom.Vec3D;

// Deprecated but working,
// please use TouchPointCloud

public class MyApp extends PaperTouchScreen {

<<<<<<< HEAD
  public void settings() {
    setDrawAroundPaper();
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);
  }

  public void setup() {
  }

  public void drawAroundPaper() {
    clear();
    noStroke();
=======
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
>>>>>>> 04daeec55a745c083c145f6c5ea487c9c928e065

    ArrayList<DepthPoint> points = ((KinectTouchInput) touchInput).projectDepthData3D((ARDisplay ) getDisplay(), screen);

    int k = 0;

<<<<<<< HEAD
    for (DepthPoint depthPoint : points) {
      PVector pos = depthPoint.getPosition();

      PVector p1 = new PVector( pos.x, 
        pos.y, 
        pos.z);

=======
	    if(pos.x < 0
	       || pos.x >= drawingSize.x
	       || pos.y < 0
	       || pos.y >= drawingSize.y)
	    	continue;
>>>>>>> 04daeec55a745c083c145f6c5ea487c9c928e065

      if (p1.x < 0
        || p1.x >= drawingSize.x
        || p1.y < 0
        || p1.y >= drawingSize.y)
        continue;

<<<<<<< HEAD
      float ellipseSize = 3;
      int c = depthPoint.getColor();
      if (c == DepthAnalysis.INVALID_COLOR) {
        fill(0, 0, 200);
      } else {
        fill(red(c), green(c), blue(c));
      }

      pushMatrix();
      translate(p1.x, p1.y, p1.z);
      ellipse(0, 0, ellipseSize, ellipseSize);
      popMatrix();
=======
	    pushMatrix();
	    translate(pos.x, pos.y, pos.z);
	    ellipse(0, 0, ellipseSize, ellipseSize);
	    popMatrix();
	}


>>>>>>> 04daeec55a745c083c145f6c5ea487c9c928e065
    }

    endDraw();
  }
}