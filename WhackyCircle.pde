Circle c = new Circle(new Point(100, 100), 50);

void settings() {
    size(displayWidth, displayWidth);
}

void setup() {
    clear();
    surface.setTitle("Whacky Circle");
    surface.setResizable(true);
}

void draw() {
    clear();
    fill(255);
    c.render();
}