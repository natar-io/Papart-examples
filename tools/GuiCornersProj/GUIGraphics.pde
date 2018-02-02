color orange = color(255, 142, 21);
color blue = color(7, 189, 255);
color black = color(0);
color white = color(255, 255, 255);

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
  translate(corners(offset).x, 
    corners(offset).y);
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

  labelX.setText(objectWidth + "")
    .setPosition(image[1].x + label1x*2, image[1].y + label1y*2);

  labelY.setText(objectHeight + "")
    .setPosition(image[3].x + label2x*2, image[3].y + label2y*2);

  popMatrix();

  zero.setPosition(image[0].x + 10, image[0].y - 10);

  xAxis.setPosition((image[1].x-image[0].x)/2+image[0].x, 
    (image[1].y - image[0].y)/2 +image[0].y-10);
  yAxis.setPosition((image[3].x-image[0].x)/2+image[0].x -10, 
    (image[3].y - image[0].y)/2+image[0].y); 

  zero.bringToFront().setColor(white);
  labelX.bringToFront().setColor(white);
  labelY.bringToFront().setColor(white);
  xAxis.bringToFront().setColor(white);
  yAxis.bringToFront().setColor(white);
}

// show textfields and buttons
public void showInputs() {
  inputHeight.setVisible(true);
  inputWidth.setVisible(true); 
  buttonOppositeX.setVisible(false);
  buttonOppositeY.setVisible(false);
  xAxis.setVisible(false);
  yAxis.setVisible(false);
  zero.setVisible(false);
  labelX.setVisible(false);
  labelY.setVisible(false);
}

// hide textfields and buttons
public void hideInputs() {
  inputHeight.setVisible(false);
  inputWidth.setVisible(false);   
  buttonOppositeX.setVisible(true);
  buttonOppositeY.setVisible(true);
  xAxis.setVisible(true);
  yAxis.setVisible(true);
  zero.setVisible(true);
  labelX.setVisible(true);
  labelY.setVisible(true);
}

// draw only the buttons
// public void drawChangeSize() {
  // titre.clear();
  // titre.append("Enter the size of the image you want to save as a marker.");
// }

// draw only the rectangles
public void drawCorners(PGraphicsOpenGL graphics) {

  fill(255, 100);
  quad(image[0].x, image[0].y, 
    image[1].x, image[1].y, 
    image[2].x, image[2].y, 
    image[3].x, image[3].y);

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


// draw the X and Y axis on the selection
// orange for X, blue for Y
public void drawAxis() {
  strokeWeight(3);

  // x Axis
  stroke(orange);
  line(image[0].x, image[0].y, image[1].x, image[1].y);

  // y Axis
  stroke(blue);
  line(image[0].x, image[0].y, image[3].x, image[3].y);
}
