enum GameState {
  MAIN_MENU, 
  RULES, 
  HIGHSCORE, 
  RUNNING_PHASES, 
  GAME_COMPLETE
}

class Game {
  private GameState gameState = GameState.MAIN_MENU;
  private GameUserInterface ui;

  private ArrayList<Phase>phases;
  private int phaseIndex = 0;

  private boolean initialized;
  private ScoreKeeper score;

  public void initialize() { 
    if (ui == null)     
      ui = new GameUserInterface();
    new AssetLoader().start();

    // New Score Keeper
    score = new ScoreKeeper();

    // Reset Phases
    phaseIndex = 0;
    Phase[] phs = { new Phase1()};
    phases = toList(phs);
    for (Phase ph : phases) ph.initialize();

    initialized = true;
  }

  class AssetLoader extends Thread {
    public void run() { 
      centerMouse = loadImage("cm.png");
    }
  }

  public Phase getPhase() {
    return listGet(phases, phaseIndex, null);
  }

  public ScoreKeeper getScore() {
    return score;
  }

  public void execute() {
    switch(gameState) {
    case MAIN_MENU:
      menuState();
      break;
    case RULES:
      ruleState();
      break;
    case HIGHSCORE:
      highScoreState();
      break;
    case RUNNING_PHASES:
      runningState();
      break;
    case GAME_COMPLETE:
      gameCompleteState();
      break;
    }
  }

  public void handleMouseClick(int x, int y) {
    switch(gameState) {
    case MAIN_MENU:
    case RULES:
    case HIGHSCORE:
      gameState = ui.onClick();
      break;
    case RUNNING_PHASES:
      try {
        getPhase().getTest().getShape().tryClick(x, y);
      } 
      catch(NullPointerException e) { /* No shape for user to click */
      }
      break;
    case GAME_COMPLETE:
      gameCompleteState();
      break;
    }
  }

  public void handleMouseWheel(int scroll) {
    ui.onScroll(scroll);
  }

  private void menuState() {
    ui.toMainMenu();
    ui.render();
  }

  private void ruleState() {
    ui.toRules();
    ui.render();
  }

  private void highScoreState() {
    ui.toHighScore();
    ui.render();
  }

  private void runningState() {
    if (!initialized) return;

    Phase p = getPhase();

    if (p == null) {
      println("WARN: Current Phase Undefined");
      return;
    }

    p.execute();
    score.displayScore();

    if (p.completedTests()) {
      ++phaseIndex;
      score.resetPhase();
    }
    if (phaseIndex == phases.size()) gameState = GameState.GAME_COMPLETE;
  }

  private void gameCompleteState() {
    println("Game Complete :party-parrot:");

    TestVisitor distVisitor = new AverageDistanceFromCenter();
    TestVisitor fittzVisitor = new TimeToClickVisitor();

    for (Phase p : phases) {
      distVisitor.acceptPhase(p);
      fittzVisitor.acceptPhase(p);
    }

    UUID gameId = saveGamePaths(phases);
    initialize();
    gameState = GameState.MAIN_MENU;
  }
}