int numDrips = 0;
int maxPointsPerTouch = 3;
int leap = 18; //how far the point travels each iteration also controls opacity
int sizeMax = 30; //how far the point travels each iteration also controls opacity

ArrayList<Drop> drips = new ArrayList<Drop>();

int lastShot = 0;
int shotDuration = 4000;

void drawBlood(){

    boolean newImage =  millis() >  lastShot + shotDuration;

    if(newImage){
	lastShot = millis();
	background(0);

        ArrayList<TouchPoint> touchs3D = new ArrayList<TouchPoint>(touchInput.getTouchPoints3D());
        for(TouchPoint tp : touchs3D){

            ArrayList<DepthDataElementKinect> depthDataElements = tp.getDepthDataElements();

            for(DepthDataElementKinect dde : depthDataElements){
                Vec3D p = dde.projectedPoint;
                noStroke();

                if(perCentChance(20)){
                    int intensity = (int) (50 + random(200));
                    PVector screenP = new PVector(p.x * width,
                                                  p.y * height);


                    stroke(intensity, 30, 30, 100 + random(100));
                    fill(intensity, 30, 30, 100 + random(100));

                    int splat = round(random(0,20));
                    // ellipse(screenP.x, screenP.y, 10, 10);
                    // point(screenP.x, screenP.y);

                    textFont(font, random(sizeMax));
                    text(splat, (int) screenP.x, (int) screenP.y);

                    if(perCentChance(8)){
                        drips.add(new Drop((int) screenP.x,
                                           (int) screenP.y,
                                           (int) (100 + random(100))));
                    }
                }

            }

        }
    }

    for (Iterator<Drop> it = drips.iterator(); it.hasNext();) {
        Drop drop = it.next();
        drop.drip();
        drop.show((PGraphicsOpenGL) g);
        drop.tryStop();
        if(!drop.isMoving){
            it.remove();
        }
    }
}
