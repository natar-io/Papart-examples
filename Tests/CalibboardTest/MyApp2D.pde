import fr.inria.papart.tracking.*;

public class MyApp extends PaperScreen {

  public void settings() {
    // the size of the draw area is 297mm x 210mm.
    setDrawingSize(297, 210);
    // loads the marker that are actually printed and tracked by the camera.
    loadMarkerBoard(Papart.markerFolder + "calib1.svg", 297, 210);
    // loadMarkerBoard(Papart.markerFolder + "A4-default.svg", 297, 210);

    // the application will render drawings and shapes only on the surface of the sheet of paper.
    setDrawOnPaper();
  }

  public void setup() {
      	setDrawingFilter(0);
  }

  public void drawOnPaper() {
      // setLocation(63, 45, 0);
      DetectedMarker[] list = papart.getMarkerList();

      println("markers :  " + list.length);

     PMatrix3D camPos = currentCamBoard();
            PVector pos3D = new PVector(camPos.m03, camPos.m13, camPos.m23);
            PVector pxCam = cameraTracking.getProjectiveDevice().worldToPixelCoord(pos3D, false);
            System.out.println("PXCam: " + pxCam);


      
    // background: blue
    background(0, 0, 200, 50); 

    // fill the next shapes with green
    fill(0, 200, 0, 70);

    noStroke();
    // draw a green rectangle
    // top projection
    rect(76f, 11.6f, 146.4f, 46.4f);

    // bot projection 
    rect(80f, 145f, 142.7f, 50f);

    // green circles
    fill(0, 255, 0);
    rect(79.8f, 123.8f, 15f, 15f);
    rect(208.2f, 123.8f, 15f, 15f);

    // purple circles
    fill(153, 0, 204);
    rect(108.1f, 123.8f, 15f, 15f);
    rect(179.4f, 123.8f, 15f, 15f);

    // red circles
    fill(255, 0, 0);
    rect(79.8f, 95.2f, 15f, 15f);
    rect(208.2f, 95.2f, 15f, 15f);

    // blue circles
    fill(0, 0, 255);
    rect(79.8f, 67.1f, 15f, 15f);
    rect(208.2f, 67.1f, 15f, 15f);

    // orange circles
    fill(255, 200, 30);
    rect(108.1f, 67.1f, 15f, 15f);
    rect(179.4f, 67.1f, 15f, 15f);

    
    
  }


    private PMatrix3D currentCamBoard() {
        return getMarkerBoard().getTransfoMat(cameraTracking).get();
    }
    
}
