MyApp app;

public class MyApp extends PaperScreen {

    PFont myFont;

    void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);

        // Here the quality is the number of pixels per millimeter rendered.

        // If the drawing width is 297mm and quality 2.0,
        // the pixel width will be 297x2 = 594.
        // Default is 2.0f

        // Try some values here.
        setQuality(2f);
    }

    void setup() {

        // Quality is important for reading text.
        myFont = createFont("Georgia", 32);
    }

    // Note that the drawing here is still
    // 0 to 297 in width, and 0 to 210 in height
    // The quality does not interfere with the
    // sizes in the real world.

    void drawOnPaper() {
        setLocation(63, 45, 0);
        background(100, 0, 0);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);

        fill(255);
        textFont(myFont);
        text("Hello World", 30, 100);
    }

}
