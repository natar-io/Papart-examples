import fr.inria.papart.procam.ColorDetection;
import fr.inria.papart.utils.MathUtils;

public class MyApp extends PaperScreen {

  TrackedView boardView;

  ColorDetection colorDetectionPaper;
  ColorDetection colorDetectionInk;


    PVector captureSize;
    PVector origin = new PVector(0, 0);
    int picSize = 32; // Works better with power  of 2
    PVector captureSizePx = new PVector(200, 100);
    
  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
  }

  public void setup() {
    boardView = new TrackedView(this);

    captureSize = new PVector(drawingSize.x / 2, drawingSize.y);
    boardView.setCaptureSizeMM(captureSize);

    boardView.setImageWidthPx((int) captureSizePx.x);
    boardView.setImageHeightPx((int) captureSizePx.y);

    boardView.setTopLeftCorner(origin);

    boardView.init();

    colorDetectionInk = new ColorDetection((PaperScreen) this);
    colorDetectionInk.setCaptureSize(20, 20);
    colorDetectionInk.setPosition(new PVector(10, 50));
    colorDetectionInk.initialize();

    colorDetectionPaper = new ColorDetection((PaperScreen) this);
    colorDetectionPaper.setCaptureSize(20, 20);
    colorDetectionPaper.setPosition(new PVector(10, 80));
    colorDetectionPaper.initialize();
  }

    int paperColor, inkColor;
    PImage capturedImage;
    
  public void drawOnPaper() {
      clear();

      capturedImage = boardView.getViewOf(cameraTracking);
      colorDetectionPaper.computeColor();
      colorDetectionInk.computeColor();

      // Debug
      // colorDetectionPaper.drawSelf();
      // colorDetectionInk.drawSelf();
      
      colorDetectionPaper.drawCaptureZone();
      colorDetectionInk.drawCaptureZone();

      paperColor = colorDetectionPaper.getColor();
      inkColor = colorDetectionInk.getColor();

      if(capturedImage == null)
	  return;

      drawCaptureZone();
      drawCapturedImage(capturedImage);


      findColorRegions();
  }
    
    void drawCaptureZone(){
	stroke(100);
	noFill();
	strokeWeight(2);
	rect((int) origin.x, (int) origin.y, 
	     (int) captureSize.x, (int)captureSize.y);
	
    }

    void drawCapturedImage(PImage img){
	image(img,
	      drawingSize.x / 2, 0,
	      captureSize.x, captureSize.y);
    }

    float dx, dy;
    
    void findColorRegions(){
      int highLightColor = color(0, 204, 0);
      int hideColor = color(96, 180);

      capturedImage.loadPixels();
      translate(origin.x, origin.y);

      noStroke();
      fill(highLightColor);
      
      dx = (captureSize.x / captureSizePx.x);
      dy = (captureSize.y / captureSizePx.y);


      for (int x=0; x < capturedImage.width  ; x++) {
	  for (int y=0; y < capturedImage.height ; y++) {
	      int offset = x + y * capturedImage.width;
	      fill(highLightColor);
	      highlightCorrectRegion(offset, x,y);

	      fill(hideColor);
	      hideWhiteRegion(offset, x, y );
	  }
      }
     
      fill(hideColor);
      // hideWhiteRegion();

    }
    
    void highlightCorrectRegion(int offset, int x, int y){    
	float hueThresh = 70;
	float satThresh = 100;
	float brightThresh = 105;
	
	if(MathUtils.colorFinderHSB(getGraphics(),
				  inkColor, capturedImage.pixels[offset],
				  hueThresh,
				  satThresh,
				  brightThresh)){
	    
	    float drawX = (x / captureSizePx.x) * captureSize.x;
	    float drawY = (y / captureSizePx.y) * captureSize.y;
	    rect(drawX, drawY, dx, dy);
	}
    }


    void hideWhiteRegion(int offset, int x, int y){
	int intensityTresh = 70;
	
	if(MathUtils.colorDistRGBAverage(paperColor, capturedImage.pixels[offset],
				  intensityTresh)){
	    
	    float drawX = (x / captureSizePx.x) * captureSize.x;
	    float drawY = (y / captureSizePx.y) * captureSize.y;
	    rect(drawX, drawY, dx, dy);
	}

    }
    
}
