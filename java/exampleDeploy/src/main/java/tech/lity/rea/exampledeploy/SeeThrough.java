package tech.lity.rea.exampledeploy;

import processing.core.*;
import fr.inria.papart.procam.*;

/**
 *
 * @author Jeremy Laviole, <laviole@rea.lity.tech>
 */
@SuppressWarnings("serial")
public class SeeThrough extends PApplet {

    Papart papart;

    @Override
    public void setup() {
        // application only using a camera
        // screen rendering
        papart = Papart.seeThrough(this);
        new MyApp();
        papart.startTracking();
    }

    @Override
    public void settings() {
        // the application will be rendered in full screen, and using a 3Dengine.
        size(640, 480, P3D);
    }

    @Override
    public void draw() {
    }

    /**
     * @param passedArgs the command line arguments
     */
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[]{SeeThrough.class.getName()};
//        if (passedArgs != null) {
//            PApplet.main(concat(appletArgs, passedArgs));
//        } else {
            PApplet.main(appletArgs);
//        }
    }
}

class MyApp extends PaperScreen {

    @Override
    public void settings() {
        // the size of the draw area is 297mm x 210mm.
        setDrawingSize(297, 210);
        // loads the marker that are actually printed and tracked by the camera.
        loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);

        // the application will render drawings and shapes only on the surface of the sheet of paper.
        setDrawOnPaper();
    }

    @Override
    public void setup() {
    }

    @Override
    public void drawOnPaper() {
        // setLocation(63, 45, 0);

        // background: blue
        background(0, 0, 200, 100);

        // fill the next shapes with green
        fill(0, 100, 0, 100);

        noStroke();
        // draw a green rectangle
        rect(98.7f, 140, 101, 12);
    }
}

