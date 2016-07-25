# Multitouch TUIO

Same as Multitouch but supports TUIO server communication.

Its working with an unofficial [TUIO library](https://github.com/poqudrof/ProcessingTUIO) slighly extended from the [original](http://www.tuio.org/?processing). 


This sketch acts like a touchScreen, the interesting part is the `TuioServer` part which enables 
the sketch to output the touch values with the instruction: 

``` java
    ArrayList<TouchPoint> touchs2D = new ArrayList<TouchPoint>(touchInput.getTouchPoints2D());
    server.send2D(touchs2D);
```

![Photo of the touch interface](https://github.com/potioc/Papart-examples/raw/master/papart-examples/Projection2D/MultiTouchTUIO/photo.jpg)

![Resulting TUIO events](https://github.com/potioc/Papart-examples/raw/master/papart-examples/Projection2D/MultiTouchTUIO/screenshot.png)
