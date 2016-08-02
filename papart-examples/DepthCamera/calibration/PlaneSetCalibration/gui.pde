float planeUp;


void initGUI(){
    image = new PVector[4];
    image[0] = new PVector(250, 250);
    image[1] = new PVector(350, 250);
    image[2] = new PVector(350, 350);
    image[3] = new PVector(250, 350);

    skatolo = new Skatolo(this, this);

    skatolo.setAutoDraw(false);
    saveButton = skatolo.addButton("saveButton")
        .setColorBackground(color(7, 189, 255))
        .setLabel("Save")
        .setPosition(20, 420)
        .setSize(90, 30);


    origin = skatolo.addPixelSelect("origin")
        .setPosition(100,100)
        .setLabel("(0, 0)")
        ;

    xAxis = skatolo.addPixelSelect("xAxis")
        .setLabel("(x, 0)")
        .setPosition(150,100)
        ;

    corner = skatolo.addPixelSelect("corner")
        .setLabel("(x, y)")
        .setPosition(150,150)
        ;

    yAxis = skatolo.addPixelSelect("yAxis")
        .setLabel("(0, y)")
        .setPosition(100,150)
        ;

    skatolo.addSlider("planeUp")
        .setPosition(0,0)
        .setSize(200,20)
        .setRange(-100,100)
        .setValue(-20)
        ;

    // create a toggle
    skatolo.addToggle("useAR")
        .setPosition(0,80)
        .setSize(50,20)
        .setLabel("use Marker")
        ;


}

void drawGUI(){
    hint(ENABLE_DEPTH_TEST);
    skatolo.draw();
    hint(DISABLE_DEPTH_TEST);
}
