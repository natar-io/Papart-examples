color orange = color(255, 142, 21);
color blue = color(7, 189, 255);
color black = color(0);

// draw a rectangle on each corner 
// (red if it's the current corner)
private void drawRectAroundCorner(int offset) {
  noFill();
  rectMode(CENTER);
  if (offset == currentCorner()) {
    stroke(225, 17, 2);
    strokeWeight(3);
  } else {
    stroke(255);
    strokeWeight(1);
  }

  pushMatrix();
  translate(corners(offset).x * width, 
    corners(offset).y * height);
  rect(0, 0, 15, 15);
  popMatrix();

  stroke(255);
  strokeWeight(1);
}

public void drawLegend() {

  float label1x = 10;
  float label1y = -10;

  float label2x = 10;
  float label2y = 10;

  pushMatrix();
  translate(image[0].x, image[0].y);

  // X 
  if (image[1].x < image[0].x || image[2].x > image[1].x)
    label1x *= -1;

  if (image[1].y > image[0].y || image[2].y < image[1].y)
    label1y *= -1;

  // Y
  if (image[3].x < image[2].x || image[2].x > image[3].x)
    label2x *= -1;

  if (image[3].y > image[2].y || image[2].y < image[3].y)
    label2y *= -1;

  labelX.setText("X")
    .setPosition(image[1].x + label1x*2, image[1].y + label1y*2);

  labelY.setText("Y")
    .setPosition(image[3].x + label2x*2, image[3].y + label2y*2);

  popMatrix();

  zero.setPosition(image[0].x + 10, image[0].y - 10);

 

  zero.bringToFront().setColor(black);
  labelX.bringToFront().setColor(black);
  labelY.bringToFront().setColor(black);
}

// hide textfields and buttons
public void hideInputs() {  
  buttonOppositeX.setVisible(true);
  buttonOppositeY.setVisible(true);
  zero.setVisible(true);
  labelX.setVisible(true);
  labelY.setVisible(true);
}

// draw only the rectangles
public void drawCorners(PGraphicsOpenGL graphics) {

  cameraDisplay.endDraw();

  DrawUtils.drawImage((PGraphicsOpenGL) g, 
    cameraDisplay.render(), 
    0, 0, width, height);

  fill(255, 100);
  quad(image[0].x * width, image[0].y * height, 
    image[1].x * width, image[1].y * height, 
    image[2].x * width, image[2].y * height, 
    image[3].x * width, image[3].y * height);

  drawAxis();

  drawLegend();

  for (int i = 0; i < 4; i++) 
    drawRectAroundCorner(i);

  int nbCorner = currentCorner()+1;
  titre.clear();
  if (!saved) {
    titre.append("Match the corner #" + nbCorner + "  with the corner #" + nbCorner 
      + " of your image.");
    int nextCorner = nbCorner+1;
    if (nextCorner <5)
      titre.append("Then press " + nextCorner + " to configure the next corner.");
  } else {
    titre.append("Position saved!");
  }
}

public PGraphicsOpenGL initDraw() {
  PImage img = camera.getImage();
  if (img == null)
    return null;

  background(0);
  image(img, 0, 0, width, height);

  PGraphicsOpenGL graphics = cameraDisplay.beginDraw();

  graphics.clear();
  return graphics;
}

// draw the X and Y axis on the selection
// orange for X, blue for Y
public void drawAxis() {
  strokeWeight(3);

  // x Axis
  stroke(orange);
  line(image[0].x * width, image[0].y * height,
       image[1].x * width, image[1].y * height);

  // y Axis
  stroke(blue);
  line(image[0].x * width, image[0].y * height,
       image[3].x * width, image[3].y * height);
}
