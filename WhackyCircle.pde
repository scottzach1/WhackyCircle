PathTracker pt = new PathTracker();
Game game = new Game();
ScoreBoard sb;


void settings() {
  size(Math.max(displayWidth / 2, 1400), Math.max(displayHeight / 2, 700));
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
