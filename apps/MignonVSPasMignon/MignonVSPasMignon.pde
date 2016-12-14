import fr.inria.papart.procam.*;
import fr.inria.papart.depthcam.*;
import fr.inria.papart.multitouch.*;

import org.bytedeco.javacv.*;
import toxi.geom.*;

KinectTouchInput touchInput;

void settings(){
    fullScreen(P3D);
}

// TODO: sound problem, not ready for 1.0

void setup(){
    Papart papart = Papart.projection2D(this);
    papart.loadTouchInput();
    touchInput = (KinectTouchInput) papart.getTouchInput();
    papart.startDepthCameraThread();
    // arguments are 2D and 3D precision.
    
    initSound();
    prepareGame();
    rectMode(CENTER);
    
    println("Initialization OK. ");
    frameRate(100);
}

Game game;
boolean debug = false;

void prepareGame(){
  game = new Game();
  game.init();
  imageMode(CENTER);
}

void draw() {

  background(0); 

  game.update();
  game.drawGame();

}


void keyPressed() {

  if(key == 'd'){
    debug = !debug;
  }

  if(key == 'a'){
    game.addElement();
    grognement();
    cri();
  }

}


void stop() {
  stopSound();
}


