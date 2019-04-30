// TODO: create a default sheet for 3D / "AroundPaper" sheets.
public class External3DPaperContent  extends PaperScreen {

  void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    setDrawAroundPaper();
  }

  void setup() {}

  void drawAroundPaper() {
    clear();
    fill(0, 200, 0);
    rect(0, 0, 40, 20);

    scale(0.5f);
    rotateX(-HALF_PI);
    rotateY((float) millis() / 1000f) ;
    shape(rocket);
  }
}
