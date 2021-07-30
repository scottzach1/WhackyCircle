PathTracker pt = new PathTracker();
boolean flick = false;
int movingX = 0;

void settings() {
  size(displayWidth/2, displayHeight/2);
}

void setup() {
  clear();
  surface.setTitle("Whacky Circle");
  surface.setResizable(true);
}

void draw() {
  fill(255);
  stroke(255);
  strokeWeight(2);
  circle(movingX++, 400, 10);
}
