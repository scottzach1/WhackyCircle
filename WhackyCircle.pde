PathTracker pt = new PathTracker();
Game game = new Game();


void settings() {
  size(displayWidth / 2, displayHeight / 2);
}

void setup() {
  clear();
  surface.setTitle("Whacky Circle");
  surface.setResizable(true);
  // FIXME: It would be nice to render later, it does not respect my window size (Zac).
  // Perhaps when the user starts the game? (my screen states it is 2560x720 until
  // I manually resize it slightly - this is definitely not its actual size).
  game.initialize();
}

void draw() {
  clear();
  game.execute();
}