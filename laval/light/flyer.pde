import fr.inria.papart.procam.camera.*;

PVector cardSize = new PVector(56, 40);

PVector infoReaderPosition = new PVector(210, 170);
PVector infoShowPosition = new PVector(infoReaderPosition.x - 210,
				       infoReaderPosition.y - 145);


float candidateFound = 0;
float[] candidatesFound = new float[5]; // 4 pages + cartes visites

static final int INVALID = -1;
int currentCandidate = INVALID;

float zeroImg = 0;
float maxZero = 35;
float maxFound = 35;
   
public class InfoReader  extends TableScreen{

    CalibratedStickerTracker stickerTracker;
    
    public InfoReader(){
	// Initial location,  width, height.
	super(infoReaderPosition, cardSize.x, cardSize.y);
	setQuality(2f);
    }
    
    public void drawOnPaper() {
	if(stickerTracker == null){
	    stickerTracker = new CalibratedStickerTracker(this, 7f);
	}
	background(70);
	ArrayList<TrackedElement> stickers = stickerTracker.findColor(millis());
	fill(255);
	noFill();
	stroke(180);
	int size = 12;
	translate(0, 0, 4); // 3mm up.


	int[] foundIDs = new int[5]; // init 0 by default in java.

	boolean noSticker = true;

	int border = 4;
	for(TrackedElement s : stickers){

	    if(s.getPosition().x < border
	       || s.getPosition().y < border
	       || s.getPosition().x > drawingSize.x - border
	       || s.getPosition().y > drawingSize.y - border 
	       ){
		continue;
	    }
	    // rect(s.getPosition().x - size/2 ,
	    // 	 s.getPosition().y -size/2,
	    // 	 size, size);
	    // text(Integer.toString(s.attachedValue),
	    // 	 s.getPosition().x,
	    // 	 s.getPosition().y - 20);

	    noSticker = false;
	    foundIDs[s.attachedValue]++;
	}

	if(noSticker){
	    zeroImg++;
	}
	if(zeroImg >= maxZero){
	    candidateFound = 0;
	    zeroImg = 0;
	    currentCandidate = INVALID;
	    println("current candidate 0");
	}
	

	checkIds(foundIDs);
	

	float amt = constrain(candidateFound / maxFound, 0, 1);
	rect(0, 0,
	     drawingSize.x * amt, 3);
	//        drawTouch(15);
    }

    // RED: 1
    // BLUE: 2
    // Green: 3

    int R = 1;
    int B = 2;
    int G = 3;
   
    void checkIds(int[] foundIDs){
	// Two red, one blue - p1
	if(foundIDs[R] == 0 && foundIDs[B] == 3){
	    candidatesFound[0]++;

	    candidateFound++;
	    zeroImg = 0;
	}

	// Two red, one blue - p2
	if(foundIDs[R] == 1 && foundIDs[B] == 2){
	    candidatesFound[1]++;
	    
	    candidateFound++;
	    zeroImg = 0;
	}
	
	// Two red, one blue - p3
	if(foundIDs[R] == 2 && foundIDs[B] == 1){
	    candidatesFound[2]++;

	    candidateFound++;
	    zeroImg = 0;
	}

	// three red, no blue  - p4
	if(foundIDs[R] == 3 && foundIDs[B] == 0){
	    candidatesFound[3]++;
	    
	    candidateFound++;
	    zeroImg = 0;
	}
	
	//  Two greens, one red card !
	if(foundIDs[R] == 1 && foundIDs[G] == 2){
	    candidatesFound[4]++;
	    
	    candidateFound++;
	    zeroImg = 0;
	}

	for(int i = 0; i < candidatesFound.length; i++){
	    if(candidatesFound[i] > maxFound){
		selectId(i);
	    }
	}
    }
    
    void selectId(int id){
	currentCandidate = id;
	resetIds();
    }

    void resetIds(){
	for(int i = 0; i < candidatesFound.length; i++){
	    candidatesFound[i] = 0;
	}
    }
    
    
}



public class InfoShow  extends TableScreen{

    PImage titre, scrollSite, ra, couleursRT, commande, soutiens;
    
    public InfoShow(){
	// Initial location,  width, height.
	super(plateauPosition,
	      //	      infoShowPosition,
	      650, 400);
	titre = loadImage("titre.png");
	scrollSite = loadImage("produit.png");
	ra = loadImage("RA2.png");
	couleursRT = loadImage("couleursRT.png");
	commande = loadImage("Commande.png");
	soutiens = loadImage("soutiens.png");

	loadVideo();
	setQuality(3f);
    }

    Camera video;
    
    void loadVideo(){
	try{
	    video = CameraFactory.createCamera(Camera.Type.FFMPEG,
					       sketchPath() + "/data/rt1.webm");
	    video.setParent(parent);
	    ((CameraFFMPEG)video).startVideo();
	} catch(CannotCreateCameraException cce){
	    println("Cannot load the camera: " + cce);
	}
    }

    public void drawOnPaper() {
	setLocation(0, 0, -2);

	if(currentCandidate != INVALID){

	    if(currentCandidate == 0){
		drawPage1();
	    }
	    if(currentCandidate == 1){
		drawPage2();
	    }
	    if(currentCandidate == 2){
		drawPage3();
	    }
	    if(currentCandidate == 3){
		drawPage4();
	    }
	    if(currentCandidate == 4){
		drawCarte();
	    }

	} else {
	    clear();
	     background(0, 0);
	}

	// updateTouch();
	// drawTouch();
    }

    void drawCarte(){
	background(0);
	image(soutiens, 0, 0, drawingSize.x, drawingSize.y);
    }
    
    void drawPage4(){
	background(0);
	image(commande, 0, 0, drawingSize.x, drawingSize.y);
	//	drawTouch();
    }

    

    float rotationColors = 0;
    
    void drawPage2(){
	background(0);
	updateTouch();

	//	noFill();
	imageMode(CORNER);
	image(ra, 0, 0, drawingSize.x, drawingSize.y);

	rotationColors += 0.01f * PI; // don't tell.

	pushMatrix();
	translate(140, drawingSize.y - 251);
	rotate(rotationColors);
	imageMode(CENTER);
	image(couleursRT, 0, 0,
	      61, 60);
	popMatrix();

	imageMode(CORNER);

	ellipseMode(CENTER);
	for(Touch t : touchList){

	    if(t.is3D){
		fill(200, 180, 120, 200);
		ellipse(t.position.x, t.position.y, 70, 70);
	    } else {
		fill(30, 180, 180);
		ellipse(t.position.x, t.position.y, 10, 10);
	    }
	}

	DepthTouchInput touchInput = (DepthTouchInput) getTouchInput();
	touchInput.projectOutsiders(true);
	ArmDetection armDetection = touchInput.getArmDetection();
	ArrayList<TrackedDepthPoint> armPointerTouch = (ArrayList<TrackedDepthPoint>)armDetection.getTipPoints().clone();
	
	if(armPointerTouch.size() > 0){
	    Touch t = projectTouch(armPointerTouch.get(0));
	    fill(255, 40, 28, 180);

	    ellipse(t.position.x,
		    drawingSize.y -t.position.y - 4
		    , 8, 8);
	}
	
	//	drawTouch();
    }
    

    float ypos = 0;
    float scale = 1.0f;

    float minScale = 0.5f;
    float maxScale = 2f;
    float scaleStep = 0.05f;
    
    void drawPage3(){
	background(0);

	pushMatrix();
	scale(scale);
	
	image(scrollSite, 30, ypos, 375.5f , 1151f); 
	popMatrix();
	
	updateTouch();

	for(Touch t : touchList){
	    if(!t.is3D && t.speed != null){
		ypos+= -t.speed.y;

		if(abs(t.speed.x) > 6f){
		    scale = scale +  scaleStep * ((t.speed.x > 0) ? -1 : 1);
		}
		break;
	    }
	}
	
	scale = constrain(scale, minScale, maxScale);
	ypos = constrain(ypos, -1000, 60);
	
	//	drawTouch();
	
    }
    

    PImage videoImage = null;
    void drawPage1(){
	image(titre, 0, 0, drawingSize.x, drawingSize.y);
	video.grab();
	PImage newImage = video.getPImage();
	if (newImage != null) {
	    videoImage = newImage;
	}
	if(videoImage!= null){
	    
	    float border = 2f;
	    float x = 241.547f;
	    float y = 141.7f;
	    float w = 280f;
	    float h = 210f;

	    imageMode(CENTER);
	    image(videoImage, x + border,
		  drawingSize.y - h - y + border,
		  w - border*2, h - border*2);
	}
    }
    
}