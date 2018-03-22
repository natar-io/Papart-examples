public class MyApp  extends PaperScreen {

    // public MyApp(Camera cam, BaseDisplay proj, TouchInput touchinput) {
    //     super(cam, proj, touchinput);
    // }

    void settings(){
	setDrawingSize(297, 210);
	loadMarkerBoard(Papart.markerFolder + "large.svg", 297, 210);
	//	loadMarkerBoard(Papart.markerFolder + "A4-calib.svg", 297, 210);
        setDrawOnPaper();
    }

    void setup(){
    }

    void drawOnPaper(){
	background(100, 80);
	rect(20, 20, 50, 20);
	fill(0, 255, 20);
	ellipse(40, 40, 10, 10);
//	drawTouch();
    }

}
