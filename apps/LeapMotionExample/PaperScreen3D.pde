import de.voidplus.leapmotion.*;


public class LeapExample  extends PaperScreen {

    void settings(){
        setDrawingSize(297, 210);
        loadMarkerBoard(Papart.markerFolder + "A3-small1.svg", 297, 210);
        setDrawAroundPaper();
    }

    void setup(){

    }

    void drawAroundPaper(){
        setLocation(63, 45, 0);

        noStroke();
        colorMode(RGB, 255);
        fill(200);

        lights();
        translate(20, 20, 0);
        box(80, 30, 11);
        translate(-10, 0, 0);

        for (Hand hand : leap.getHands ()) {
            for (Finger finger : hand.getFingers()) {
                drawFinger(finger);
            }
        }
    }

    void drawFinger(Finger finger){
        int     finger_id         = finger.getId();
        PVector finger_position   = finger.getRawPosition();

        colorMode(HSB, 10, 1, 1);
        fill(finger.getType(), 1, 1);
        pushMatrix();
        translate(finger_position.x, -finger_position.z, -finger_position.y);
        sphere(5);
        popMatrix();

        for(int i = 0; i <= 3; i++){
            drawBone(finger.getBone(i), i);
        }
    }

    void drawBone(Bone bone, int id){
        PVector prevJoint = bone.getRawPrevJoint();
        fill(5 + id, 1, 1);
        pushMatrix();
        translate(prevJoint.x, -prevJoint.z, -prevJoint.y);
        sphere(5);
        popMatrix();
    }

}
