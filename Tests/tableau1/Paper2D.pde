import fr.inria.papart.tracking.ObjectFinder;

MyApp app;

public class MyApp  extends PaperScreen {

    public MyApp(Camera cam, BaseDisplay proj) {
       super(cam, proj); 
    }
  
  PImage tableauImg;
    public void settings(){
      
      ObjectFinder.briskParam1 = 20;
      ObjectFinder.briskParam2 = 2;
      //ObjectFinder.briskParam1 = 30;
      try{
        setDrawingSize(485, 680);
        loadMarkerBoard(Papart.markerFolder + "mega-calib.svg", 297, 210);
        //loadMarkerBoard(sketchPath() + "/ExtractedView.bmp", 485, 680);
        setDrawOnPaper();
    app = this;
      } catch(Exception e){
        println("Exceptino "  + e );
        e.printStackTrace();
      }
}

    public void setup() {
      tableauImg = loadImage("tableau.jpg");
    }
    

    public void drawOnPaper() {
      
      //setLocation(100, 100, 0);
        background(255);
        fill(200, 100, 20);
        rect(10, 10, 100, 30);
        image(tableauImg, 0, 0, drawingSize.x, drawingSize.y);
    }
}