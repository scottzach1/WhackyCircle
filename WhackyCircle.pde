Test t = new Test(5, new TestAttr[0]);

void settings() {
  size(displayWidth/2, displayHeight/2);
}

void setup() {
  clear();
  surface.setTitle("Whacky Circle");
  surface.setResizable(true);
}

void draw() {
  clear();
  fill(255);
  t.run();
}
