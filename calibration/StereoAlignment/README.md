# Stereo Alignment

## Foreword

For some depth camera, the stereo alignment must be put by hand. It is the case for:

* OpenKinect.
* OpenKinect2. 

This program is **useless** for these cameras that have builtin calibration: 

* RealSense. 

## How to use:

Move the slider left or right until you get a good alignment. Then press the save button.

Notes: 

* 0 is no alignment at all: exactly the same location. 
* The slider amount is in millimeter. 

## Misalignment example:

Notice the problem with the legos. Everything looks weirder. 

![From depth camera point of view](https://github.com/poqudrof/Papart-examples/blob/master/papart-examples/DepthCamera/calibration/invalid.png)


## Correct alignment:

It is not clear, when everything works it looks good.

![From my point of view](https://github.com/poqudrof/Papart-examples/blob/master/papart-examples/DepthCamera/calibration/SteroAlignment/correct.png)



