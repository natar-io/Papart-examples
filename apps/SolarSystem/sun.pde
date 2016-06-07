PVector sunLocation = new PVector();
PMatrix3D sunLoc = new PMatrix3D();

PaperScreen sun;

public class Sun extends PaperScreen {

  PShape sunModel;
  PShader texlightShader;

  public void settings() {
    setDrawingSize( (int) boardSize.x, (int)boardSize.y);
    loadMarkerBoard(sketchPath() + "/data/markers/sun/sun.svg", 
      boardSize.x, boardSize.y);
    setDrawAroundPaper();
  }

  public void setup() {
    sunModel = loadShape("sphere2/sun.obj");
    texlightShader = loadShader("shaders/texlightfrag.glsl", "shaders/texlightvert.glsl");
    sun = this;
  }
  
  public void drawAroundPaper() {
    ambient(255);

    translate(160, 60, 0);
    rotateZ( (float) millis() / 50000f);

    // 	diamètre Soleil : 1 392 684 km
    scale(planetScale * 1392684 / 40f);
    scale(0.5f);
    sunModel.draw(getGraphics());
  }
}