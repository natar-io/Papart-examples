public class Moon extends PaperScreen {

  PShape moonModel;

  public void setup() {
    moonModel = loadShape("sphere2/moon.obj");
  }

  public void settings() {
    setDrawingSize( (int) boardSize.x, (int)boardSize.y);
    loadMarkerBoard(sketchPath() + "/data/markers/moon/moon.svg",
      boardSize.x, boardSize.y);
    setDrawAroundPaper();
  }

  public void drawAroundPaper() {

    pushMatrix();
    goTo(sun);
    pointLight(255, 255, 255, 0, 0, -50);
    popMatrix();

    translate(160, 60, 0);
    rotateZ( (float) millis() / 4000f);

    // Diamètre de la lune 3 474 km
    scale(planetScale * 3447f);

    shader(texlightShader);
    moonModel.draw(getGraphics());
    resetShader();
  }
}
