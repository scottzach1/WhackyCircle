PathTracker pt = new PathTracker();
Game game = new Game();
ScoreBoard sb;


void settings() {
  size(displayWidth / 2, displayHeight / 2);
}

void setup() {
  clear();
  surface.setTitle("Whacky Circle");
  surface.setResizable(true);
  game.initialize();

  ArrayList<MetricRow> metrics = loadMetrics("metrics.csv");
  saveMetrics(metrics);
}

void draw() {
  clear();
  game.execute();
}
