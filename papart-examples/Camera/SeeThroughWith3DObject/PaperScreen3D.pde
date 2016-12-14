// TODO: create a default sheet for 3D / "AroundPaper" sheets.

public class PaperScreen3D  extends PaperScreen {

    PShape rocketShape;

    void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
        setDrawAroundPaper();
    }

    void setup(){
        rocketShape = loadShape("data/rocket.obj");
    }

    void drawAroundPaper(){
        setLocation(63, 45, 0);
        scale(0.5f);
        rotateX(-HALF_PI);
        rotateY((float) millis() / 1000f) ;
        shape(rocketShape);
    }
}
