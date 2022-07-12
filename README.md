# Papart library examples.

Here are the Papart examples, to show atomic features.
Papart stands for PAPer Augmented Reality Toolkit. The core library is 
available on this [repository](https://github.com/natar-io/PapARt).

## PapARt 1.6 - Back to monolith, and compability updates. 

See update description in [PapARt repository](https://github.com/natar-io/PapARt).

## PapARt 1.4 - Circle tracker and Natar preparation

This new release brings many new features. It is now easier to place PaperScreen on the table with 
the new TableScreen class. 

The color tracking and particularly the circular tracking is quite robust and enable the creation of 
physical interfaces with a high detection rate. There will be a complete tutorial on how to create 
a mixed reality interface with touch and circle tracking. 

We work to improve the current API, as it will be part of the coming Nectar platform. The main 
motivation for Nectar to push further the possibilites of SAR with PapARt. The rendering will not
be limited to Processing for rendering with the Unity3D Nectar plugin. The plugin is in 
internal test/development phase, and is already quite promising. 

### New features

* Color tracking, with dedicated color calibration. 
* `TableScreen`: Place a screen relative to the table location. 
* New tracking: colored object (any shape), circular shape, marker, TouchSimulator, mouse.
* Unified tracking handling for [Skatolo](https://github.com/Rea-lity-Tech/Skatolo). 
* Nectar compatiblity: many new features are coming through the nectar platform such as more marker trackers, QR code reader, barcode reader.
* API without Processing windows is expanding for Nectar.

### Changes 

* The method `loadSketches` is removed. This method created way too many magical instances. You need to instanciate the PaperScreen and PaperTouchScreen yourself now. 
* New examples: 3D mapping, circle detection, color detection, video player, advanced gui.
* The finger tracking is less magical also as we got many new ways to activate buttons. You get an object to retreive the touchList.

#### Initialization
``` java
TouchDetectionDepth fingerDetection;

public void setup() {
    Papart.projection(this);
    fingerDetection = papart.loadTouchInput().initHandDetection();
    new MyApp();
    papart.startTracking();
}

```

#### In a PaperTouchScreen:
``` java 
TouchList fingerTouchs = getTouchListFrom(fingerDetection);
     for (Touch t : fingerTouchs) {
	    PVector p = t.position;
	    ellipse(p.x, p.y, 10, 10);
	}
```


## Guides and support

To be updated. 

### Video:
[![](https://github.com/poqudrof/PapARt/blob/master/video_screenshot.png?raw=true)](https://youtu.be/bMwKVOuZ9EA)

## Research project (2010~2016)

This library and examples are the result of research projects from Inria and Bordeaux University. 
* Inria project : [website](https://project.inria.fr/papart/fr/)

Video from the research project:
[![](https://github.com/potioc/Papart-examples/blob/master/screenshot2.png?raw=true)](https://youtu.be/ZBndzLAM5I8)


## What are the branches ?

* Master / main is the only current branch. 
## Copyright

This code is propriety of CATIE, Jérémy Laviole, Inria, and Bordeaux University.
