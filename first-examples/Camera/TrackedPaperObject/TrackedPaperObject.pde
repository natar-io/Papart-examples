// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.tracking.*;
import tech.lity.rea.svgextended.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;
import org.openni.*;

Papart papart;
PVector boardSize = new PVector(1, 1);  //  21 * 29.7 cm

ARDisplay display;
Camera cameraTracking;
MarkerBoard markerBoard;

public void settings(){ 
    size(800*2, 600*2, P3D);
}

public void setup(){
    papart = Papart.seeThrough(this);

    display = papart.getARDisplay();
    // The drawing is not automatic.
    display.manualMode();

    // camera = display.getCamera();
    cameraTracking = papart.getCameraTracking();

    markerBoard = MarkerBoardFactory.create(
        "test1.svg",
        (int) boardSize.x,
        (int) boardSize.y);

    // Ask the camera to track this markerboard
    cameraTracking.trackMarkerBoard(markerBoard);

    // Filtering on the tracking
    //markerBoard.setDrawingMode(cameraTracking, true, 10);
    markerBoard.setFiltering(cameraTracking, 30, 4);

    // Create a view of part of the tracked piece of paper.
    // The resolution (two last arguments) should be at maximum the camera resolution.

    // Start tracking the pieces of paper.
    cameraTracking.trackSheets(true);

    papart.startTracking();
}

void draw(){
    background(0);
    
    // draw the camera image
    if (cameraTracking != null && cameraTracking.getPImage() != null) {
      image(cameraTracking.getPImage(), 0, 0, width, height);
    }

    PMatrix3D markerBoardMatrix = markerBoard.getPosition(cameraTracking);

    // Uncomment to display the matrix.
    // markerBoardMatrix.print();
    PGraphicsOpenGL gr = display.beginDraw();

    gr.clear();
    gr.pushMatrix();
    gr.applyMatrix(markerBoardMatrix);
    // gr.translate(200, -200);

    gr.lights();
    drawAxes(gr);
    drawA4Sheet(gr);
    drawBox(gr);

    gr.popMatrix();
    display.endDraw();

    // draw the AR
    display.drawImage((PGraphicsOpenGL) g, display.render(), 
                       0, 0, width, height);
}

void drawAxes(PGraphicsOpenGL gr){
    gr.stroke(200, 0, 0);
    gr.line(0, 0, 100, 0);
    gr.stroke(0, 200, 0);
    gr.line(0, 0, 0, 100);
    gr.stroke(0, 0, 200);
    gr.line(0, 0, 0, 0, 0, 100);   
}

void drawA4Sheet(PGraphicsOpenGL gr){ 
    gr.stroke(50, 200);
    gr.fill(150, 100);
    gr.rect(0, 0, 297, 210);
}

void drawBox(PGraphicsOpenGL gr){
    gr.fill(180);
    gr.stroke(0); 
    gr.translate(10, 10, -12);
    gr.box(20);
}
