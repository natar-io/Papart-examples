// http://openprocessing.org/sketch/20818
// Asher Salomon
// AsherSalomon@gmail.com

public class MyBlocks extends PaperTouchScreen {

    class TouchWithSpeed {
	PVector p;
	PVector s;
    }

    // L : size of the square.
    float L = 7;
    float I;
    float gravity = 0.06;
    float spring = 0.15;
    float damping = 0.001;
    ArrayList blocks;

    int maxBlocks = 400;
    int minBlocks = 100;

    PMatrix3D lastPos = null;

    void settings(){
	setDrawingSize(320, 210);
	loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 320, 210);
	// loadMarkerBoard(sketchPath() + "/data/markers/blocks.svg", 320, 210);
        setDrawAroundPaper();
    }


    void setup(){
	getMarkerBoard().setDrawingMode(cameraTracking, false, 1);

	I = L*L/6;

	blocks = new ArrayList();
	for (int i=0;i< 200;i++) {
	    blocks.add(new block());
	}
    }

    // public void resetPos() {
    // 	screen.resetPos();
    // }

    public void drawAroundPaper() {

	// setLocation(-30, -218, 0);

	if(blocks.size() <= 10)
	    for(int i = 0; i < 50; i++)
		blocks.add(new block());

	PVector paperVelocity = null;
	if (lastPos != null) {
	    lastPos.m00 = 1;
	    lastPos.m11 = 1;
	    lastPos.m22 = 1;
	    lastPos.m01 = 0;
	    lastPos.m02 = 0;
	    lastPos.m10 = 0;
	    lastPos.m12 = 0;
	    lastPos.m20 = 0;
	    lastPos.m21 = 0;

	    // Maybe the Z axis is inverted ? Or any other axis ?
	    lastPos.invert();

	    //	    PMatrix3D newPos = board.getTransfoMat(cameraTracking);
	    PMatrix3D newPos = this.getLocation().get();


	    // Compute the difference with the initial...
	    newPos.preApply(lastPos);

	    paperVelocity = new PVector(-newPos.m03, -newPos.m13);

	    // if(newPos.m03 != 0)
	    // 	    println(newPos.m03 +" " + newPos.m13 + " "+ newPos.m23);
	}

	colorMode(HSB, 1);
	background(0, 0, 0, 0);

	try{

            for (Touch t : touchList) {
		if(t.is3D)
		    continue;

		PVector v  = t.position;
		if (v.x > drawingSize.x * 0.1f && v.x < drawingSize.x * 0.9f &&
		    v.y > drawingSize.y * 0.1f && v.y < drawingSize.y * 0.9) {

		    PVector touchLocation = t.position;

		    if (blocks.size() < maxBlocks)
			blocks.add(new block(touchLocation.x + random(-10, 10), touchLocation.y + random(-10, 10)));
		}
	    }
	}catch(Exception e){
	    println("Error while adding blocks" + e );
	}

	try{

	    for (int i=1;i<blocks.size();i++) {
		block blk = (block) blocks.get(i);
		for (int j=0;j<i;j++) {
		    block blk2 = (block) blocks.get(j);
		    PVector dx = PVector.sub(blk2.location, blk.location);
		    if ((abs(dx.x)<L*1.5)&&(abs(dx.y)<L*1.5)) {
			if (dx.mag()<L*0.8) {
			    float restore = 3*spring*(L-dx.mag());
			    dx.normalize();
			    dx.mult(restore);
			    blk2.forceSum.add(dx);
			    blk.forceSum.sub(dx);
			    blk2.pressure += dx.mag();
			    blk.pressure += dx.mag();
			}
			else if (dx.mag()<L*1.5) {
			    blk.testPoints(blk2);
			    blk2.testPoints(blk);
			}
		    }
		}
	    }
	}catch(Exception e){
	    println("Error while Updating blocks" + e );
	}


	ArrayList toRemove = new ArrayList();


	ArrayList<TouchWithSpeed> touchs = new ArrayList();

	try{
            for (Touch t : touchList) {

                // TODO: check this mystery
                // if(t.p == null)
                //     println("Null P " + t + touch.touches.size()) ;

                // 3D touches.
                if (!t.is3D)
                    continue;

                PVector p = t.position;
                PVector s = t.speed;

                PVector touchLocation = new PVector(p.x,
                                                    p.y + 30, 0);
                PVector touchSpeed1 = new PVector(s.x,
                                                  s.y, 0);

                noStroke();
                fill(1, 0, 1);
                float ellipseSize = touchSpeed1.mag();
                ellipse(touchLocation.x, touchLocation.y,
                           ellipseSize, ellipseSize);

                TouchWithSpeed tws = new TouchWithSpeed();
                tws.p = touchLocation;
                tws.s = touchSpeed1;
                touchs.add(tws);
            }
	}catch(Exception e){
	    println("Error while Updating Touch" + e );
	}

	try{
	    for (int i=0;i<blocks.size();i++) {
		block blk = (block) blocks.get(i);

		if (blk == null)
		    continue;

		//      Blocks stick to the paper. It is not a force.
		if(paperVelocity != null && blk.location != null){
		    blk.location.add(paperVelocity);
		}

		for (TouchWithSpeed t : touchs){

		    PVector touchLocation = t.p;
		    PVector touchSpeed1 = t.s;

		    noStroke();
		    fill(1, 0, 1);

		    PVector dx = PVector.sub(blk.location, touchLocation);


		    if(dx.mag()<L*0.75){
			//		    println("Apply force !");
			blk.forceSum.add(PVector.mult(PVector.sub(
                                                          touchSpeed1,blk.velocity),0.8));
			stroke(255);
			line(blk.location.x,
				blk.location.y,
				touchLocation.x,
				touchLocation.y);
			noStroke();
		    }
		}

		blk.testWalls();
		blk.update();
		blk.draw(getGraphics());

		if (blk.age < millis()) {
		    if (blocks.size() > minBlocks){
			//	toRemove.add(blk);
		    }
		}
	    }

	}catch(Exception e){
	    println("Error while Updating Block location & Drawing" + e );
	}


	blocks.removeAll(toRemove);

	stroke(100);
	noFill();
	strokeWeight(2);
	rect(0, 0, drawingSize.x, drawingSize.y);
	noStroke();


	lastPos =  this.getLocation().get();
    }




    class block {
	PVector location;
	PVector velocity;
	PVector forceSum;
	float angle;
	float angularSpeed;
	float momentSum;
	PVector ui;
	PVector uj;
	PVector[] pointsToTest;
	float pressure;
	float age;

	block() {
	    this(random(L, drawingSize.x -L), random(L, drawingSize.y -L));
	}

	block(float px, float py) {
	    location = new PVector(px, py);
	    velocity = new PVector();
	    forceSum = new PVector();
	    ui = new PVector(1, 0);
	    uj = new PVector(0, 1);
	    pointsToTest = new PVector[12];
	    for (int i=0;i<12;i++) {
		float rad = L/2/cos(PI/6);
		if (i%3==0) {
		    rad=L/2*pow(2, 0.5);
		}
		float phi = i*PI/6+PI/4;
		pointsToTest[i] = new PVector(
                    rad*cos(phi),
                    rad*sin(phi));
	    }
	    pressure = 0;
	    age = millis() +10000 + random(-5000, 5000);
	}

	void update() {
	    velocity.add(forceSum);

	    velocity.x = constrain(velocity.x, -20, 20);
	    velocity.y = constrain(velocity.y, -20, 20);
	    //    velocity.mult(0.98);
	    forceSum.set(0, gravity);
	    location.add(velocity);
	    angularSpeed+=momentSum/I;
	    angularSpeed = constrain(angularSpeed, -PI/4, PI/4);
	    momentSum = 0;
	    angle+=angularSpeed;
	    angularSpeed*=0.99;
	    ui.set(cos(angle), sin(angle));
	    uj.set(-ui.y, ui.x);
	}

	void draw(PGraphicsOpenGL pg) {

            pg.noStroke();
            // pg.smooth();

fill(0.67-pressure*0.2, 1, 1, 1.0);
	    pg.beginShape();
	    for (int i=0;i<12;i+=3) {
		PVector testPoint  = toWorld(pointsToTest[i]);
		testPoint.add(location);

		pg.vertex(testPoint.x, testPoint.y);
	    }
	    pg.endShape(CLOSE);
	    pressure = 0;
	}

	PVector toOri(PVector w) {
	    PVector o = new PVector();
	    o.x = w.dot(ui);
	    o.y = w.dot(uj);
	    return o;
	}
	PVector toWorld(PVector o) {
	    PVector w = new PVector();
	    w.x = ui.x * o.x + uj.x * o.y;
	    w.y = ui.y * o.x + uj.y * o.y;
	    return w;
	}
	PVector feild(PVector atPoint) {
	    PVector atBlock = toOri(PVector.sub(atPoint, location));
	    PVector value = new PVector();
	    if (abs(atBlock.x)>abs(atBlock.y)) {
		if (abs(atBlock.x)<L/2) {
		    if (atBlock.x>0) {
			value.x = spring*(L/2-abs(atBlock.x));
		    }
		    else {
			value.x = -spring*(L/2-abs(atBlock.x));
		    }
		}
	    }
	    else {
		if (abs(atBlock.y)<L/2) {
		    if (atBlock.y>0) {
			value.y = spring*(L/2-abs(atBlock.y));
		    }
		    else {
			value.y = -spring*(L/2-abs(atBlock.y));
		    }
		}
	    }
	    return toWorld(value);
	}
	void testPoints(block otherBlock) {
	    for (int i=0;i<12;i++) {
		PVector testPoint = toWorld(pointsToTest[i]);
		testPoint.add(location);
		PVector force = otherBlock.feild(testPoint);
		PVector dv = PVector.sub(
                    otherBlock.velocityAt(testPoint),
                    velocityAt(testPoint));
		force.add(PVector.mult(dv, damping));
		applyForce(force, testPoint);
		otherBlock.applyForce(PVector.mult(force, -1), testPoint);
	    }
	}
	void testWalls() {
	    for (int i=0;i<12;i+=3) {
		PVector testPoint = toWorld(pointsToTest[i]);
		testPoint.add(location);
		PVector force = wallFeild(testPoint);
		PVector dv = velocityAt(testPoint);
		force.sub(PVector.mult(dv, damping));
		applyForce(force, testPoint);
	    }
	}
	PVector wallFeild(PVector atPoint) {
	    PVector value = new PVector();
	    if (atPoint.x<0) {
		value.x = -spring*atPoint.x;
	    }
	    if (atPoint.x>drawingSize.x) {
		value.x = -spring*(atPoint.x-drawingSize.x);
	    }
	    if (atPoint.y<0) {
		value.y = -spring*atPoint.y;
	    }
	    if (atPoint.y>drawingSize.y) {
		value.y = -spring*(atPoint.y-drawingSize.y);
	    }
	    return value;
	}
	void applyForce(PVector force, PVector atPoint) {
	    PVector arm = PVector.sub(atPoint, location);
	    momentSum += arm.cross(force).z;
	    forceSum.add(force);
	    pressure += force.mag();
	}
	PVector velocityAt(PVector atPoint) {
	    return PVector.add((new PVector(0, 0, angularSpeed)).cross(
                                   PVector.sub(atPoint, location)), velocity);
	}
    }
}
