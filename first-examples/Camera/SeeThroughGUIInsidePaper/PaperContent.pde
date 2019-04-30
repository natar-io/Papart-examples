import fr.inria.papart.multitouch.*;

public class PaperContent extends PaperScreen {

  Skatolo skatolo;

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    setDrawOnPaper();
    setQuality(2f);
  }

  void setup() {
    skatolo = new Skatolo(this.parent, this);
    // Disable the main (screen) mouse pointer
    skatolo.getMousePointer().disable();
    skatolo.setAutoDraw(false);

    skatolo.addHoverButton("changeBackgroundColor")
            .setPosition(5, 5)
            .setSize(120, 20)
            .setCaptionLabel("Change background color");

    skatolo.addHoverToggle("showRectangle")
            .setPosition(5, 30)
            .setSize(70, 20)
            .setCaptionLabel("Show Rectangle");
  }

  // this value is automagically changed by skatolo.
  boolean showRectangle = false;

  int paperBackgroundColor = 0;
  // this method is automagically called when the button is pressed.
  void changeBackgroundColor() {
    paperBackgroundColor += 1;
    if (paperBackgroundColor == 10) {
      paperBackgroundColor = 0;
    }
  }

  public void drawOnPaper() {

    // background of the sheet is blue
    colorMode(HSB, 10, 1, 1);
    clear();
    background(paperBackgroundColor, 1, 1);

    TouchList touchList =  new TouchList();
    // use the paper-projected mouse pointer
    SkatoloLink.addMouseTo(touchList, skatolo, this);
    SkatoloLink.updateTouch(touchList, skatolo);

    skatolo.draw(getGraphics());

    if(showRectangle){
      fill(2, 0.2f, 0.5f);
      rect(10, 150, 100, 75);
    }
  }
}
