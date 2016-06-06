public class Earth extends PaperScreen {

  PShape earthModel;
  PShader texlightShader;

  public void setup() {
    earthModel = loadShape("sphere2/earth.obj");
    texlightShader = loadShader("shaders/texlightfrag.glsl", "shaders/texlightvert.glsl");
  }

  public void settings() {
    setDrawingSize( (int) boardSize.x, (int)boardSize.y);
    loadMarkerBoard(sketchPath() + "/data/markers/earth/earth.svg", 
      boardSize.x, boardSize.y);
    setDrawAroundPaper();
  }

  public void drawAroundPaper() {

    ambientLight(50, 50, 50);

    // light coming from the sun
    // TODO trouver pourquoi la lumière vient du côté opposé
    pushMatrix();
    goTo(sun);
    for (int i = 0; i <= 2; i++) {
      pointLight(200, 200, 200, 0, 0, i * 10);
    }
    popMatrix();

    // set the correct angle and position
    translate(160, 60, 0);
    rotateX(-HALF_PI);
    rotateY( (float) millis() / 20000f); 
    
    // diamètre de la terre : 12 742 kilomètres
    scale(planetScale * 12742f);
    earthModel.draw(getGraphics());
  }
}