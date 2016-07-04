boolean saved = false;

public PVector corners(int id) {
  return image[id];
}

public int currentCorner() {
  return currentPt;
}

void mouseDragged() {
  if (Mode.is("corners"))
    image[currentPt] = new PVector(mouseX, mouseY);
}

int currentPt = 0;

public void moveCornerUp(boolean isUp, float amount) {
  image[currentPt].y += isUp ? -amount : amount;
}

public void moveCornerLeft(boolean isLeft, float amount) {
  image[currentPt].x += isLeft ? -amount : amount;
}

void keyPressed() {

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

  if (key == CODED) {
    if (keyCode == UP) 
      moveCornerUp(true, 1);

    if (keyCode == DOWN) 
      moveCornerUp(false, 1);

    if (keyCode == LEFT) 
      moveCornerLeft(true, 1);

    if (keyCode == RIGHT) 
      moveCornerLeft(false, 1);
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

  boardView.setCorners(image);
  view = boardView.getViewOf(camera);
  view.save(sketchPath("ExtractedView.bmp"));
  println("Saved");
  saved = true;
}