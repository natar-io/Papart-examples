MyApp app;

public class MyApp extends PaperScreen {

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    setDrawOnPaper();
  }
    // Default keys are used explicitly.
    // By default alt is required.
  public void setup() {
      useAlt(false);
      setLoadKey("l");
      setSaveKey("s");
      setTrackKey("t");
      setSaveName("loc.xml");
  }

  public void drawOnPaper() {
    background(100, 0, 0);
    fill(200, 100, 20);
    rect(10, 10, 100, 30);
  }
}
