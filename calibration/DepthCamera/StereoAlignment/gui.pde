float xOffset, yOffset;
Skatolo skatolo;

void initGUI(){

    skatolo = new Skatolo(this, this);
    skatolo.setAutoDraw(false);
    skatolo.addButton("saveButton")
        .setColorBackground(color(7, 189, 255))
        .setLabel("Save")
        .setPosition(20, 420)
        .setSize(90, 30);

    int range = 30;

    // TODO: load the value
    skatolo.addSlider("xOffset")
        .setPosition(0,0)
        .setSize(6* range,20)
        .setRange(-range, range)
        .setValue(stereoCalib.m03)
        ;
    skatolo.addSlider("yOffset")
        .setPosition(0,20)
        .setSize(6* range,20)
        .setRange(-range, range)
        .setValue(stereoCalib.m13)
        ;
}


void saveButton(){
    println("SaveButton");
    toSave=  true;
}

void drawGUI(){
    cam.beginHUD();
    hint(ENABLE_DEPTH_TEST);
    skatolo.draw();
    hint(DISABLE_DEPTH_TEST);
    cam.endHUD();
}
