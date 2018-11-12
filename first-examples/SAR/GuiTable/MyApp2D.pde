import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.detection.*;
import fr.inria.papart.multitouch.tracking.*;

import tech.lity.rea.colorconverter.*;
import redis.clients.jedis.Jedis;

// TODO: same with tableScreen instead...

public class MyApp  extends TableScreen {

    Skatolo skatolo;
    ColorTracker colorTracker;
    CalibratedStickerTracker stickerTracker;
    Jedis redis;
       
    public MyApp(){
	super(-200, -200, 400, 400);
    }
    

    void setup() {

	// redis = new Jedis("oj.lity.tech", 8089);
	redis = new Jedis("127.0.0.1", 6379);
	
	// Color Tracker
	colorTracker = papart.initBlueTracking(this, 1f);

	// Sticker tracker 
	stickerTracker = new CalibratedStickerTracker(this, 15);

	// Marker tracker
	initTouchListFromMarkers(335, 341, 44, false);

	// GUI
	skatolo = new Skatolo(this.parent, this);
	skatolo.getMousePointer().disable();
	skatolo.setAutoDraw(false);

	skatolo.addHoverButton("button")
	    .setPosition(0, 60)
	    .setSize(60, 60)
	    ;

	skatolo.addHoverToggle("toggle")
	    .setPosition(100, 60)
	    .setSize(60, 60)
	    ;

    }

    boolean toggle = false;
    void button(){
        println("button pressed");
        println("Toggle value " + toggle);
	rectColor += 30;
    }

    float rectColor = 0;
    
    void drawOnPaper(){
	// setLocation(63, 45, 0);
        background(10);

	TouchList allTouchs = new TouchList();

	// MOUSE
	SkatoloLink.addMouseTo(allTouchs, skatolo, this); // comment to disable

	// Marker
	try{
	TouchList markerTouchs = getTouchListFromMarkers();
	drawMarkers(markerTouchs);
	allTouchs.addAll(markerTouchs);  // comment to disable
	} catch(Exception e){
	    //	    System.out.println("exception " + e);
	}

	// STICKER
	stickerTracker.findColor(millis());
	TouchList stickerTouchs = getTouchListFrom(stickerTracker);
	allTouchs.addAll(stickerTouchs);   // comment to disable

 	// redis.set(output + ":depth:width", Integer.toString(cam.width()));
	
	// COLOR
	colorTracker.findColor(millis());
	TouchList colorTouchs = getTouchListFrom(colorTracker);
	allTouchs.addAll(colorTouchs);   // comment to disable

	// FINGERS
	TouchList fingerTouchs = getTouchListFrom(fingerDetection);
	allTouchs.addAll(fingerTouchs);   // comment to disable

	// Feed the touchs to Skatolo to activate buttons. 
	SkatoloLink.updateTouch(allTouchs, skatolo);
	// Draw the interface
	skatolo.draw(getGraphics());


	// Draw the pointers. (debug)
	drawPointers();
	drawTouch(fingerTouchs);
	
	if(toggle){
	    fill(rectColor);
	    rect(70, 70, 20, 20);
	}
    }

    public void setTouchListToRedis(Jedis connection, String key, TouchList list, String listType){

	JSONArray touchListJSON = new JSONArray();
        int k = 0;

	for(Touch t : list){
	    JSONObject touch = new JSONObject();

	    touch.setString("type", listType);
	    
	    touch.setFloat("x", t.position.x);
	    touch.setFloat("y", t.position.y);
	    touch.setFloat("z", t.position.z); // Z can be height (mm) , or orientation (Radians)

	    touch.setFloat("px", t.pposition.x);
	    touch.setFloat("py", t.pposition.y);
	    touch.setFloat("pz", t.pposition.z); // Z can be height (mm) , or orientation (Radians)

	    touchListJSON.setJSONObject(k++, touch);
	}
	connection.set(key + ":" + listType, touchListJSON.toString());
    }

    void drawPointers(){
	for (tech.lity.rea.skatolo.gui.Pointer p : skatolo.getPointerList()) {
	    fill(0, 200, 0);
	    rect(p.getX(), p.getY(), 3, 3);
	}
    }

    void drawTouch(TouchList fingerTouchs){
	fill(255, 0, 20);
        for (Touch t : fingerTouchs) {
	    PVector p = t.position;
	    ellipse(p.x, p.y, 10, 10);
	}

    }

    void drawMarkers(TouchList markerTouchs){
	fill(255, 0, 20);
	colorMode(HSB, 10, 100, 100);
        for (Touch t : markerTouchs) {
	    pushMatrix();
	    translate(t.position.x, t.position.y);
	    rotate(t.position.z);
	    fill(t.id, 100, 100);
	    rect(-10, -10, 20, 20);
	    popMatrix();
	}

	colorMode(RGB, 255);
    }

    
}
