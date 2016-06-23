void drawCameraAR(){
    cameraDisplay.drawScreens(); // offscreen rendering
    noStroke();

    camera = papart.getCameraTracking();

    // draw the camera image
    if (camera != null && camera.getPImage() != null) {
        image(camera.getPImage(), 0, 0, width, height);
    }
    // draw the AR
    cameraDisplay.drawImage((PGraphicsOpenGL) g, cameraDisplay.render(),
                            0, 0, width, height);
}

PlaneCalibration getPlaneFromPaper(){
    PlaneCalibration planeCalib = PlaneCalibration.CreatePlaneCalibrationFrom(app.getLocation(), new PVector(10, 10));
    planeCalib.flipNormal();
    return planeCalib;
}


void drawValidPoints( PlaneCalibration planeCalib, HomographyCalibration homography){

    boolean useHomography = homography != HomographyCalibration.INVALID;
    int w = cameraDisplay.getWidth();
    int h = cameraDisplay.getHeight();

    int size = 4;

    for(int y = 0; y < h; y += size){
        for(int x = 0;  x < w; x += size){

            float x1 = (float)x / (float) w;
            float y1 = (float)y / (float) h;

            PVector loc = cameraDisplay.getProjectedPointOnPlane(planeCalib, x1, y1);

            if(loc ==  TouchInput.NO_INTERSECTION)
                continue;

            PVector loc2 = depthAnalysis.findDepthAtRGB(loc);

            if(loc2.equals(TouchInput.NO_INTERSECTION))
                continue;

            //            planeCalib.flipNormal();
            planeCalib.moveAlongNormal(planeUp);

            if(useHomography){
                PMatrix3D transfo = homography.getHomography();
                PVector normalized = new PVector();
                transfo.mult(loc2, normalized);

                normalized.x = normalized.x / normalized.z;
                normalized.y = normalized.y / normalized.z;

                if(normalized.x > 0 && normalized.x < 1
                   &&
                   normalized.y > 0 && normalized.y < 1){

                    fill(normalized.x * 255, normalized.y * 255, 0);
                    rect(x, y, 1, 1);

                    Vec3D pos = new Vec3D(loc2.x, loc2.y, loc2.z);

                    if(planeCalib.hasGoodOrientation(pos)){

                        // if(planeCalib.distanceTo(pos) > 20){
                        fill(normalized.x * 255, normalized.y * 255, 200);
                            rect(x, y, size, size);
                        // } else {
                        //     fill(normalized.x * 255, normalized.y * 255, 0);
                        //     rect(x, y, 1, 1);
                        // }
                    } else {
                        fill(200, 0, 0);
                        rect(x, y, size, size);
                    }


                }
            } else {
                fill(200, 0, 0);
                rect(x, y, size, size);
            }
            planeCalib.moveAlongNormal(-planeUp);
            //            planeCalib.flipNormal();

        }
    }



}
