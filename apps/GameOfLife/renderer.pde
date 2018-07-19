
// public
int gridSize = 5; // 1 cm.
PVector nbElements = new PVector(rendererSize.x / gridSize,
				 rendererSize.y / gridSize);
Conway2D gameOfLife = new Conway2D((int) nbElements.x, (int) nbElements.y); 

public class LifeRenderer  extends TableScreen {
    public LifeRenderer(){
	super(initPos.x, initPos.y, rendererSize.x, rendererSize.y);
    }
    void setup() {}
    void drawOnPaper(){
	// a little bit visible
        background(40);
	drawGameOfLife();
    }

    

    void drawGameOfLife(){
	byte[] data = gameOfLife.getData();
	int w = gameOfLife.getWidth();
	int h = gameOfLife.getHeight();
	int k = 0;
	stroke(0);
	
	for(int y = 0; y < h; y++){
	    for(int x = 0; x < w; x++ ){
		byte d = data[k++];
		fill(255, 0, 0);
		if(d == 0){
		    fill(0);
		}
		if( d == 1){
		    fill(255);
		}
		rect(x* gridSize,
		     y*gridSize,
		     (float)gridSize-0.2f,
		     (float) gridSize-0.2f);
	    }
	}
    }
}
