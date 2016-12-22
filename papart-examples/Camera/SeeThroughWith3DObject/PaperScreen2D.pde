// Following Processing Example
// https://github.com/processing/processing-docs/blob/master/content/examples/Basics/Shape/LoadDisplayOBJ/LoadDisplayOBJ.pde


public class PaperScreen2D  extends PaperScreen {

    PShape rocket;
    float ry;

    void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
        setDrawOnPaper();
    }

    void setup(){
        rocket = loadShape("data/rocket.obj");
    }

    void drawOnPaper(){
        background(100, 100);
        lights();

        translate(drawingSize.x /2, drawingSize.y /2 , -200);
        rotateZ(PI);
        rotateY(ry);
        shape(rocket);

        ry += 0.02;
    }
}
