import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

public class ModelMapper  extends PaperTouchScreen {

  PShape model;
  PShader texlightShader;

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    setDrawAroundPaper();
  }

  public void setup() {
    model = loadShape("catd.obj");
    texlightShader = loadShader("shader/texlightfrag.glsl", "shader/texlightvert.glsl");
  }

  public void drawAroundPaper() {
    background(0);

    ambientLight(255, 255, 255);

    // Get the touchInput
    DepthTouchInput touchInput = (DepthTouchInput) getTouchInput();
    touchInput.projectOutsiders(true);
    ArmDetection armDetection = touchInput.getArmDetection();
    ArrayList<TrackedDepthPoint> armPointerTouchs = (ArrayList<TrackedDepthPoint>)armDetection.getTipPoints().clone();

    if (armPointerTouchs.size() > 0) {
      Touch t = projectTouch(armPointerTouchs.get(0));
      pointLight(255, 255, 255, t.position.x, t.position.y + drawingSize.y + 20, -t.position.z);
      pushMatrix();
      {
        translate(t.position.x, t.position.y + drawingSize.y + 20, -t.position.z);
        fill(255, 0, 0);
        ellipse(0, 0, 10, 10);
      }
      popMatrix();
    }

    shader(texlightShader);

    scale(100f / 136f);
    scale(-1, 1, -1);
    shape(model);

  }
}
