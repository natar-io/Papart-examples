import fr.inria.papart.procam.ColorDetection;

int ech = 128; // power of 2
int freq = 30;

public class ColorApp extends PaperScreen {

    ColorDetection[] detections;
    ColorDetection colorDetection;
    TrackedView boardView;

  // 5cm
  PVector captureSize = new PVector(10, 10);
  PVector origin = new PVector(100, 100);
  int picSize = 8; // Works better with power  of 2

  void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
  }

    int captureW = 25; // 1cm
    int w = 10;
    int h = 10;
    
  void setup() {

      detections = new ColorDetection[w*h];
      int k = 0;
      for(int i = 0; i < w; i++){
	  for(int j = 0; j < h; j++){
	      ColorDetection cd = new ColorDetection((PaperScreen) this);
	      cd.setPosition(new PVector(i*captureW, j*captureW));
	      cd.setCaptureSize(new PVector(captureW,captureW));
	      cd.setPicSize(4, 4);
	      cd.init();
	      cd.initBlinkTracker(freq, ech);
	      detections[k++] = cd;
	  }

      }

      // Version with one tracker only.
      
      // colorDetection = new ColorDetection((PaperScreen) this);
      // colorDetection.setPosition(origin);
      // colorDetection.setCaptureSize(captureSize);
      // colorDetection.setPicSize(picSize, picSize);
      // colorDetection.init();
      // colorDetection.initBlinkTracker(freq, 0.25f, ech);

      useAlt(false);
      setLoadKey("l");
      setSaveKey("s");
      setTrackKey("f");
      setSaveName("loc.xml");
  }

  void drawOnPaper() {
    clear();
    colorMode(RGB, 255);
    background(100, 100);

    colorMode(RGB, 15);
    noStroke();
    for(int i = 0; i < w*h; i ++){
	ColorDetection cd = detections[i];
	cd.recordBlinkRate();
	cd.findBlinkRate();
	PVector fr = cd.getFreqR();
	PVector fg = cd.getFreqG();

	if(fr.y + fg.y > 5f){
	fill(fr.x * fr.y, fg.x * fr.y, 8, 6);
	rect(cd.getPosition().x,
	     cd.getPosition().y,
	     captureW, captureW);
	}
    }
    // Compute the color from the pixels. 
    //    colorDetection.computeColor();

    //     colorDetection.recordBlinkRate();
    // if(test){
    // 	colorDetection.findBlinkRate();
    // 	// re = colorDetection.re();
    // 	// im = colorDetection.im();
    // 	rer = colorDetection.rer();
    // 	imr = colorDetection.imr();
    // 	reg = colorDetection.reg();
    // 	img = colorDetection.img();

    // }

    
    // colorDetection.recordBlinkRate();
    // if(test){
    // 	colorDetection.findBlinkRate();
    // 	// re = colorDetection.re();
    // 	// im = colorDetection.im();
    // 	rer = colorDetection.rer();
    // 	imr = colorDetection.imr();
    // 	reg = colorDetection.reg();
    // 	img = colorDetection.img();

    // }

    // // Get the result.
    // int c = colorDetection.getColor();
    // fill(c);
    // int nbfound = colorDetection.computeOccurencesOfColor(c, 10);
    // // println("We found: " + nbfound + " pixels of this color.");
    // // For visual debugging.
    // colorDetection.drawSelf();
  }
}
