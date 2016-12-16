void drawCameraDepth(){
    image(depthAnalysis.getColouredDepthImage(), 0, 0, width, height);
}


PlaneCalibration getPlaneFromDepth(){
    PlaneCreator creator = new PlaneCreator();

    Vec3D[] depth = depthAnalysis.getDepthPoints();

    PVector originScreen = getPositionOf(origin);
    PVector xAxisScreen = getPositionOf(xAxis);
    PVector yAxisScreen = getPositionOf(yAxis);

    Vec3D originPoint = depth[screenToDepth(originScreen)];
    Vec3D xAxisPoint = depth[screenToDepth(xAxisScreen)];
    Vec3D yAxisPoint = depth[screenToDepth(yAxisScreen)];

    creator.addPoint(originPoint);
    creator.addPoint(xAxisPoint);
    creator.addPoint(yAxisPoint);

    creator.setHeight(15); // in mm
    return creator.getPlaneCalibration();
}


int screenToDepth(PVector screenPos){
    float w = depthCameraDevice.getDepthCamera().width();
    float h = depthCameraDevice.getDepthCamera().height();

    int x = (int) (screenPos.x / (float) width * w);
    int y = (int) (screenPos.y / (float) height * h);
    return (int) (y * w + x);
}



void drawValidPointsDepth( PlaneCalibration planeCalib, HomographyCalibration homography){

    boolean useHomography = homography != HomographyCalibration.INVALID;
    int w = depthCameraDevice.getDepthCamera().width();
    int h = depthCameraDevice.getDepthCamera().height();

    Vec3D[] depth = depthAnalysis.getDepthPoints();

    int size = 4;

    noStroke();
    for(int y = 0; y < h; y += size){
        for(int x = 0;  x < w; x += size){

             Vec3D locV = depth[y * w + x];
             PVector loc = toPVector(locV);
            // if z = 0 : invalid.


             if(loc.z <= 100)
                continue;

             // if(random(1000) < 1)
             //     println(loc);

             planeCalib.moveAlongNormal(planeUp);

             if(useHomography && planeCalib.hasGoodOrientation(locV)){
                 float d = planeCalib.distanceTo(locV);

                 PMatrix3D transfo = homography.getHomography();
                 PVector normalized = new PVector();
                 transfo.mult(loc, normalized);

                 normalized.x = normalized.x / normalized.z;
                 normalized.y = normalized.y / normalized.z;

                 if(normalized.x > 0 && normalized.x < 1
                    &&
                    normalized.y > 0 && normalized.y < 1){

                     int px = (int) ((float) x / (float) w * width);
                     int py = (int) ((float) y / (float) h * height);

                     if(planeCalib.hasGoodOrientation(locV)){
                         fill(normalized.x * 255, normalized.y * 255, d /100f * 255);
                         rect(px, py, size, size);
                     } else {
                         fill(255, 0, 0);
                         rect(px, py, size, size);
                     }
                 }
             }

             planeCalib.moveAlongNormal(-planeUp);
             // if(planeCalib.hasGoodDistance(locV)){
             //     fill(0, 200, 0);
             //     rect(x, y, 1, 1);
             // }

//             if(planeCalib.hasGoodOrientation(locV)){


//             if(useHomography){
//                 PMatrix3D transfo = homography.getHomography();
//                 PVector normalized = new PVector();
//                 transfo.mult(loc, normalized);

//                 normalized.x = normalized.x / normalized.z;
//                 normalized.y = normalized.y / normalized.z;

//                 if(random(1000) < 1)
//                     println(normalized);

//                 if(normalized.x > 0 && normalized.x < 1
//                    &&
//                    normalized.y > 0 && normalized.y < 1){

//                     fill(normalized.x * 255, normalized.y * 255, 0);
//                     rect(x, y, 1, 1);

// //                    Vec3D pos = new Vec3D(loc2.x, loc2.y, loc2.z);

//                     if(planeCalib.hasGoodOrientation(locV)){

//                         // if(planeCalib.distanceTo(pos) > 20){
//                         fill(normalized.x * 255, normalized.y * 255, 200);
//                             rect(x, y, 2, 2);
//                         // } else {
//                         //     fill(normalized.x * 255, normalized.y * 255, 0);
//                         //     rect(x, y, 1, 1);
//                         // }
//                     } else {
//                         fill(200, 0, 0);
//                         rect(x, y, 2, 2);
//                     }


//                 }
//             } else {
//                 fill(200, 0, 0);
//                 rect(x, y, 1, 1);
//             }



//             //            planeCalib.flipNormal();

        }
    }



}
