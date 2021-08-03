PathTracker pt = new PathTracker();
Game game = new Game();


void settings() {
  size(displayWidth / 2, displayHeight / 2);
}

void setup() {
  clear();
  surface.setTitle("Whacky Circle");
  surface.setResizable(true);
  game.initialize();

  ScoreBoard scores = importScoreBoard();
  scores.export();

  ArrayList<MetricRow> metrics = loadMetrics("metrics.csv");
  saveMetrics(metrics);
}

void draw() {
  clear();
  game.execute();
}
