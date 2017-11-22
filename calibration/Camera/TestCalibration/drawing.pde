
import fr.inria.papart.utils.DrawUtils;

void drawAR(){
    if(pose == null){
	return;
    }

    PGraphicsOpenGL graphics = display.beginDraw();

    graphics.clear();
    graphics.pushMatrix();
    
    // Goto to the screen position
    graphics.applyMatrix(pose);
    graphics.noStroke();
    graphics.fill(255, 180);
    graphics.rect(0, 0, 100, 100);

    graphics.popMatrix();
    
    display.endDraw();

    // render() applies the lens distorsions when necessary.
    DrawUtils.drawImage((PGraphicsOpenGL) this.g,
			display.render(),
			0, 0, width, height);
    

    //    image(display.render(), 0, 0, width, height);
}


void drawMarkerDetection(){
    if(markersDetected == null){
	return;
    }
    for(int i = 0; i < markersDetected.length; i++){
	DetectedMarker m = markersDetected[i];
	double[] corners = m.corners;

	if(m.confidence < 1.0) {
	    continue;
	}
	int ellipseSize  = 4;
	fill(255);

	stroke(255);
	text(Integer.toString(m.id),
	     (float) corners[0] + 20,
	     (float) corners[1]);

	line((float) corners[0],
	     (float) corners[1],
	     (float) corners[2],
	     (float) corners[3]);

	line((float) corners[2],
	     (float) corners[3],
	     (float) corners[4],
	     (float) corners[5]);

	line((float) corners[4],
	     (float) corners[5],
	     (float) corners[6],
	     (float) corners[7]);

	line((float) corners[6],
	     (float) corners[7],
	     (float) corners[0],
	     (float) corners[1]);
	noStroke();		
	ellipse((float) corners[0],
		(float) corners[1], ellipseSize, ellipseSize);
	ellipse((float) corners[2],
		(float) corners[3], ellipseSize, ellipseSize);
	ellipse((float) corners[4],
		(float) corners[5], ellipseSize, ellipseSize);
	ellipse((float) corners[6],
		(float) corners[7], ellipseSize, ellipseSize);
    }
}
