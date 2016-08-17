## Video Recorder

This sketch allows you to record a stream of images captured by the camera. 
It uses the Processing function `saveFrame` to save images to ram directly on Linux. 

Comment the first `saveFrame`, and uncomment the second one in the draw() method to 
save in the sketch's folder.

``` java
    if(isRecording){
        // Linux only -- Save to RAM
        saveFrame("/dev/shm/image-###.png");

        // Save to Disk
        // saveFrame("image-###.png");
}
```

