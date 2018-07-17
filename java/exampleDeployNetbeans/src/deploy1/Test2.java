/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deploy1;

import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;
import processing.core.*;
import fr.inria.papart.procam.*;
import java.util.ArrayList;
import static processing.core.PConstants.HSB;
import static processing.core.PConstants.P3D;

/**
 *
 * @author Jeremy Laviole, <laviole@rea.lity.tech>
 */
@SuppressWarnings("serial")
public class Test2 extends PApplet {

    Papart papart;

    public void setup() {
//        papart = Papart.projection(this);
        papart = Papart.seeThrough(this);
        papart.loadTouchInput().initHandDetection();
        new MyApp2();
        papart.startTracking();
    }

    public void settings() {
        // the application will be rendered in full screen, and using a 3Dengine.
        size(640, 480, P3D);
//        fullScreen(P3D);
    }

    public void draw() {
    }

    /**
     * @param passedArgs the command line arguments
     */
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[]{Test2.class.getName()};
//        if (passedArgs != null) {
//            PApplet.main(concat(appletArgs, passedArgs));
//        } else {
        PApplet.main(appletArgs);
//        }
    }
}

class MyApp2 extends MainScreen {

    public void drawOnPaper() {
        background(0);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);
        drawTouch(15);
        try {
            ArrayList<TrackedElement> te = stickerTracker.findColor(parent.millis());
            fill(89);
            ArrayList<TrackedElement> se = stickerTracker.smallElements();
            colorMode(HSB, 5, 100, 100);

            stroke(8, 10, 80);
            for (TrackedElement e : te) {
                fill(e.attachedValue, 100, 50);
                float x = e.getPosition().x;
                float y = e.getPosition().y;

                //	    ellipse(x - 4,y - 4, 8, 8);
                ellipse(x - 10, y - 10, 20, 20);
            }
            noStroke();
            for (TrackedElement e : se) {
                fill(e.attachedValue, 100, 70);
                float x = e.getPosition().x;
                float y = e.getPosition().y;

                ellipse(x, y, 4, 4);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        // println("Size "  + te.size());
        // captureView();
    }
}
