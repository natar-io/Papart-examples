public class PaperContent extends PaperScreen {
// public class PaperContent extends TableScreen {

//     public PaperContent(){
//     	super(-200, -200, 400, 400);
//     }
    
  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard("a4-default", 297, 210);
    setDrawOnPaper();
  }

  public void setup() {
  }

  public void drawOnPaper() {
    clear();

    colorMode(HSB, 10, 1, 1);
    background(paperBackgroundColor, 1, 1);

    text("Hello world", 10, 10);
    fill(2, 0.2f, 0.5f);
    rect(10, 20, 100, 75);

    fill(2, 1, 1);
    text("Hello world", 10, 10);
	
  }
}
