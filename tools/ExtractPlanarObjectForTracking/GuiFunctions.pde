boolean saved = false;

public PVector corners(int id) {
  return image[id];
}

public int currentCorner() {
  return currentPt;
}

void mouseDragged() {
    if(locked){
	return;
    }
    if (Mode.is("corners")){
	image[currentPt] = new PVector((float) mouseX / (float) width,
				       (float) mouseY / (float) height);
    }
}

int currentPt = 0;

public void moveCornerUp(boolean isUp, float amount) {
  image[currentPt].y += isUp ? -amount : amount;
}

public void moveCornerLeft(boolean isLeft, float amount) {
  image[currentPt].x += isLeft ? -amount : amount;
}

boolean locked = false;

void keyPressed() {

    if (key == ESC){
	key = 0;
    }
 
    if(key == 'l'){
	locked = !locked;
    }
    
    if(locked){
	return;
    }
    
  if (Mode.is("corners")) {
    if (key == '1')
      currentPt = 0;

    if (key == '2')
      currentPt = 1;

    if (key == '3')
      currentPt = 2;

    if (key == '4')
      currentPt = 3;
  }

  float moveSpeed = 0.005f;
  
  if (key == CODED) {
    if (keyCode == UP) 
	moveCornerUp(true, moveSpeed);

    if (keyCode == DOWN) 
	moveCornerUp(false, moveSpeed);

    if (keyCode == LEFT) 
	moveCornerLeft(true, moveSpeed);

    if (keyCode == RIGHT) 
	moveCornerLeft(false, moveSpeed);
    
  }
}

public void setModeCorners() {
  Mode.set("corners");
}

// reverse the X axis
public void oppositeX() {
  PVector tmp;

  tmp = image[0];
  image[0] = image[1];
  image[1] = tmp;

  tmp = image[3];
  image[3] = image[2];
  image[2] = tmp;
}

// reverse the Y axis
public void oppositeY() {
  PVector tmp;

  tmp = image[0];
  image[0] = image[3];
  image[3] = tmp;

  tmp = image[1];
  image[1] = image[2];
  image[2] = tmp;
}

public void save() {

    // TODO: mult all this by scale...
    
    boardView.setCorners(image);

    PVector[] resized = new PVector[4];

    for(int i = 0; i < 4; i++){
	resized[i] = new PVector(image[i].x  *  camWidth,
				 image[i].y * camHeight);
    }
    boardView.setCorners(resized);

    view = boardView.getViewOf(camera);
    //  view.save(sketchPath("ExtractedView.bmp"));
  view.save("/home/ditrop/OpenJobs/photo.jpg");

  // Runtime.getRuntime().exec("/home/ditrophost -t a " + domain);
  
  println("Saved");
  saved = true;
}
