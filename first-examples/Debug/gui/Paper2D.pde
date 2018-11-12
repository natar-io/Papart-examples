import fr.inria.papart.multitouch.*;

import tech.lity.rea.skatolo.*;
import tech.lity.rea.skatolo.events.*;
import tech.lity.rea.skatolo.gui.controllers.*;

import redis.clients.jedis.Jedis;


public class MyApp  extends PaperTouchScreen {

    Skatolo skatolo;
    Jedis redis;
    
    void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    }

    void setup() {

	// redis = new Jedis("oj.lity.tech", 8089);
	redis = new Jedis("127.0.0.1", 6379);

	
	// TODO: check this getMousePointer...
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

	// Local Touch - Warning 3334 instead of 3333
	connectLocalTUIO(3334);
    }

    boolean toggle = false;
    float rectColor = 0;
    
    void button(){
        println("button pressed");
        println("Toggle value " + toggle);
	rectColor += 30;
    }

    void drawOnPaper() {
	if(mouseSetLocation){
	    setLocation(mouseX, mouseY,0 );
	}

	
	colorMode(RGB, 255);
	background(180, 200);

	fill(200, 100, 20);
	rect(10, 10, 100, 30);

	TouchList tlTest = new TouchList();
	SkatoloLink.addMouseTo(tlTest, skatolo, this);
	setTouchListToRedis(redis, "touchTest", tlTest, "m");
	
	TouchList tuioTouch = getLocalTUIOTouchList();
	TouchList tuioTouch2 = getTouchList(touchInputTuio);

	setTouchListToRedis(redis, "touchTest", tuioTouch2, "t");
	setTouchListToRedis(redis, "touchTest", tuioTouch2, "t2");
	
	tuioTouch.addAll(tuioTouch2);
	
	SkatoloLink.addMouseTo(tuioTouch, skatolo, this);
	SkatoloLink.updateTouch(tuioTouch, skatolo);
	skatolo.draw(getGraphics());

	colorMode(HSB, 20, 100, 100);
	for(Touch touch : tuioTouch){


	    int size = 10;
	    if(tuioTouch2.contains(touch)){
		size= 15;
	    }
	    fill(touch.id, 100, 100);
	    stroke(255);
	    ellipse(touch.position.x,
		    touch.position.y, size, size);
	}

	if(toggle){
	    fill(rectColor);
	    rect(70, 70, 20, 20);
	}
    }


    public void setTouchListToRedis(Jedis connection, String key, TouchList list, String listType){

	JSONObject obj = new JSONObject();
	JSONArray touchListJSON = new JSONArray();
        int k = 0;

	for(Touch t : list){
	    JSONObject touch = new JSONObject();

	    touch.setString("type", listType);
	    touch.setFloat("id", t.id);
	    touch.setFloat("x", t.position.x);
	    touch.setFloat("y", t.position.y);
	    touch.setFloat("z", t.position.z); // Z can be height (mm) , or orientation (Radians)

	    touch.setFloat("px", t.pposition.x);
	    touch.setFloat("py", t.pposition.y);
	    touch.setFloat("pz", t.pposition.z); // Z can be height (mm) , or orientation (Radians)

	    touchListJSON.setJSONObject(k++, touch);
	}

	obj.setJSONArray("touchs", touchListJSON);

	connection.set(key + ":" + listType, obj.toString());
	connection.publish(key + ":" + listType, obj.toString());
	
    }



    
}
