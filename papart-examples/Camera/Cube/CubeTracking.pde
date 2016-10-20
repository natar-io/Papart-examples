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
    box(60);
  }
}
