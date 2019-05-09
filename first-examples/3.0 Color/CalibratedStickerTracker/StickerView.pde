import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;


public class StickerView  extends PaperTouchScreen {
  CalibratedStickerTracker stickerTracker;
  ArrayList<TrackedElement> stickers;
  Integer stickerSize = 8;

  public void settings() {
    setDrawingSize(297, 210);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);
    setDrawOnPaper();
    setQuality(2.0f);
  }

  public void setup() {
    // Uses Papart.colorZoneCalib for tracking parameters.
    stickerTracker = new CalibratedStickerTracker(this, stickerSize);
  }

  public void drawOnPaper() {
    clear();
    background(150, 40);

    stickers = stickerTracker.findColor(millis());
    int[] foundIDs = new int[5];
    for(TrackedElement s : stickers) {
      int c = stickerTracker.getReferenceColor(s.attachedValue);
      pushStyle();
      {
        noFill();
        strokeWeight(2);
        stroke(red(c), green(c), blue(c));
        rect(s.getPosition().x - stickerSize/2, s.getPosition().y -stickerSize/2, stickerSize + 2, stickerSize + 2);
      }
      popStyle();
      foundIDs[s.attachedValue]++;
    }
    if (DRAW_CLUSTER) {
      drawClusters();
    }
    if (DRAW_LINES) {
      drawLines();
    }
  }

  void drawLines() {
    // Create line clusters.
    //ArrayList<LineCluster> lines = stickerTracker.createLineClusters(40);
    ArrayList<LineCluster> lines = LineCluster.createLineCluster(stickers, 40);
    noFill();
    colorMode(HSB, lines.size(), 100, 100);
    int k = 0;
    for(LineCluster line : lines){
      stroke(k++, 100, 100);
      drawLineBorders(line);
      drawOrientation(line);
    }
    colorMode(RGB, 255);
  }

  void drawLineBorders(LineCluster line ) {
    TrackedElement[] borders = line.getBorders();
    line(borders[0].getPosition().x, borders[0].getPosition().y,
    borders[1].getPosition().x, borders[1].getPosition().y);
  }

  // Use rotation and translation.
  void drawOrientation(LineCluster line) {
    float a = (float) line.angle();
    PVector p = line.position();
    pushMatrix();
    {
      translate(p.x, p.y);
      rotate(a);
      rect(0, 0, 40, 2);
    }
    popMatrix();
  }

  void drawClusters() {
    float clusterWidth = 24;
    ArrayList<StickerCluster> clusters = stickerTracker.clusters(clusterWidth);
    //ArrayList<StickerCluster> clusters = StickerCluster.createZoneCluster(stickers, clusterWidth);
    for (StickerCluster cluster : clusters) {
      pushStyle();
      {
        noFill();
        strokeWeight(3);
        stroke(255);
        ellipseMode(CENTER);
        ellipse(cluster.center.x, cluster.center.y, clusterWidth, clusterWidth);
      }
      popStyle();
    }
  }
}
