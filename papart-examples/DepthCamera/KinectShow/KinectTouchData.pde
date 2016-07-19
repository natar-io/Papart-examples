import fr.inria.papart.depthcam.DepthData;
import fr.inria.papart.depthcam.analysis.*;
import java.util.ArrayList;
import toxi.geom.Vec3D;

// Deprecated but working,
// please use TouchPointCloud

public class MyApp extends PaperTouchScreen {


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

    ArrayList<DepthPoint> points = ((KinectTouchInput) touchInput).projectDepthData3D((ARDisplay ) getDisplay(), screen);

    float ellipseSize = 3;

    for (DepthPoint depthPoint : points) {
      PVector pos = depthPoint.getPosition();

      PVector p1 = new PVector( pos.x,
        pos.y,
        pos.z);


      if(pos.x < 0
         || pos.x >= drawingSize.x
         || pos.y < 0
         || pos.y >= drawingSize.y)
          continue;

      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      ellipse(0, 0, ellipseSize, ellipseSize);
      popMatrix();
    }

  }
}
