
## Camera initialization

This example shows how to instanciate a camera for PapARt. Here we create a camera to watch the user's desktop.

``` java 
  camera2 = CameraFactory.createCamera(Camera.Type.FFMPEG, ":0.0+1280,0", "x11grab");

  camera2.setSize(800, 400);
  camera2.setParent(this);
  camera2.start();
  
  camera2.grab();
  PImage im = camera2.getPImage();
  if(im != null){
	  image(im, 0, 0, drawingSize.x, drawingSize.y);
  }
  ```
  
  Here is another example for a physical camera:
  ``` java 
  camera2 = CameraFactory.createCamera(Camera.Type.FFMPEG, "/dev/video0");

  camera2.setSize(640, 480);
  camera2.setParent(this);
  camera2.start();
  
  camera2.grab();
  PImage im = camera2.getPImage();
  if(im != null){
	  image(im, 0, 0, drawingSize.x, drawingSize.y);
  }
  ```
  
  ## Camera types
  
The camera types are discussed in the [hardware configuration](https://github.com/poqudrof/Papart-examples/wiki/hardware-configuration) wiki page. You can check out the camera types in the javadoc:
http://jiii.fr/papart/papart/javadoc/fr/inria/papart/procam/camera/Camera.Type.html 

Camera instanciation is done uniquely though the CameraFactory class. 
