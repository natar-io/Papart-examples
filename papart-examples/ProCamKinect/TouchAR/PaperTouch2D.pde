public class MyApp  extends PaperTouchScreen {

    public void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);
        setDrawOnPaper();
    }

    public void setup() {

    }

    public void drawOnPaper() {
        background(40, 40, 40);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);
        drawTouch(15);
    }
}