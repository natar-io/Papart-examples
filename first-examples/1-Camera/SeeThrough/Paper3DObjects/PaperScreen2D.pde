public class Internal2DPaperContent  extends PaperScreen {
  private float ry;

  void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    setDrawOnPaper();
  }

  void setup() {}

  void drawOnPaper() {
    clear();
    background(100, 100);

    fill(255, 0, 0);
    rect(40, 0, 40, 20);

    lights();

    translate(drawingSize.x /2, drawingSize.y /2 , -200);
    rotateZ(PI);
    rotateY(ry);
    shape(rocket);

    ry += 0.02;
  }
}
