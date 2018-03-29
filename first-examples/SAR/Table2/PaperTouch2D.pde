import fr.inria.papart.multitouch.tracking.*;
import fr.inria.papart.multitouch.detection.*;
import tech.lity.rea.colorconverter.ColorConverter;

public class MyApp  extends TableScreen{

    public MyApp(){
	// Initial location,  width, height.
	super(new PVector(0, 0), 200f, 120f);
    }
    
    public void drawOnPaper() {
        background(200);
	//	setLocation(new PVector(mouseX, mouseY));
        fill(200, 100, 20);
        rect(10, 10, 100, 30);
        drawTouch(15);
    }
}
