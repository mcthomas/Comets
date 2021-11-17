import java.util.*;  

int start = 0;
int[] colorArr = {100, 100, 100};
List<float[]> fireworks = new ArrayList<float[]>();
int width = 800;

//Set the window size
void setup() {
    
    size(800,800);
    //background(0);

}

//At each frame, re-color the background with a semi-transparent overlay and call drawFirework()
void draw() {

    noStroke();
    fill(0,0,0,3);
    rect(0,0,width,width);
    start += 1;
    updateColorArr();
    drawFireworks();

    }
    
    //Iterate through the fireworks list, marking out of range tuples for deletion, and drawing the rest, before separately removing those marked for deletion
    void drawFireworks() {
    List<float[]> expiredFireworks = new ArrayList<float[]>();
    for(float[] firework : fireworks) {
        if(firework[0] > width || firework[1] > width) {
            expiredFireworks.add(firework);
        }
        else {
        fill(100+colorArr[0],100+colorArr[1],100+colorArr[2],255);
        ellipse(firework[0], firework[1], 10.0, 10.0);

        float scaleFactor = firework[2] / .5;
        //When does x / y = 160?           ((x / y) / 160)
        firework[0] += (firework[3] * (1/firework[2]));
        firework[1] += (firework[2] * (1/firework[2]));
        print(firework[2]);
        print("\n");
        }
    }
    for(float[] firework : expiredFireworks) {
        fireworks.remove(firework);
    }
    }

    //Initializes a coord tuple at the current mouse position; inserts into fireworks array
    void createFirework(int xCoord, int yCoord) {
       float xMirror = 400.0 + (400.0 - xCoord);
       float slope = (yCoord/(abs(xMirror-xCoord)));
       int xDir = 0;
       if(xMirror > 400) {
           xDir = -1;
       }
       else{
           xDir = 1;
       }
       float[] firework = {xMirror, 0.0, slope, xDir};
       fireworks.add(firework);
    }

//Randomly assigns RGB values to uniformly apply to fireworks drawn
void updateColorArr() {
    colorArr[(int)random(3)] += 2;
    colorArr[(int)random(3)] += 4;
    colorArr[(int)random(3)] += 6;
    if(colorArr[0] > 255) {
        colorArr[0] = 100;
    }
    if(colorArr[1] > 255) {
        colorArr[1] = 100;
    }
    if(colorArr[2] > 255) {
        colorArr[2] = 100;
    }
}

//Detects mouse click events for calling createFirework()
void mouseClicked() {
    createFirework(mouseX, mouseY); 

}
