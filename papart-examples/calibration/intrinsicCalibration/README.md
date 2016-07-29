## Intrinsic Calibration

This sketch enables the calibration of a projector or a camera. 
You can switch from one to the other by switching the variable `useProjector`;
``` java
boolean useProjector=false;   // calibrate a camera.
```

### What are intrinsics ?

It reprensents the internal parameters of the camera: the **field of view** and the **optical center**. 
In cameras the optical center is at the center of the image. For projectors the optical center is 
usually higher nowadays: you can place your projector on a table and it will project over it ([illustration](https://www.avforums.com/threads/understanding-image-offset-mounting-above-screen.1884203/)).

## How to use

Two windows pop-up: 
- Calibration view. 
- Control panel. 

In the control panel, you can set the `focal` value, `cx`, and `cy`. By default `cx` and `cy` are located in the middle 
of the image, and it the desired values for a camera. 

### Setting the focal

1. You must print the image: [carres](https://github.com/potioc/Papart-examples/blob/master/papart-examples/calibration/intrinsicCalibration/data/carres.svg) and 
place it **aligned with focal plane**, which means **facing the camera**. You need to place it a known/measured distance, and 
set this distance there in `intrinsicCalibration.pde`
``` java
float distancePaper = 1000f;   // placed at 1 meter from the camera.
```

2. Align the camera / paper so that the printed blue square is aligned with the on displayed in the calibration view. 
3. Move the `focal` slider so that the blue and green squares displayed match the printed ones. 
4. Hit `s` to save the focal length, it will create a `calib.yaml` file which can be used later in [PCConfiguration](https://github.com/potioc/Papart-examples/tree/master/papart-examples/calibration/PCConfiguration).


### Setting the optical center (projector only)

You may have problems succeding in the step `3`. While you change the focal, try to set the `cy` value to match the 
printed elements. Once it is done remember to save the calibration !
