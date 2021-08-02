enum GameState {
  MAIN_MENU,
  LOADING,
  RUNNING_PHASES,
  GAME_COMPLETE
}

class Game {
  private GameState gameState = GameState.MAIN_MENU;

  private ArrayList<Phase>phases;
  private int phaseIndex = 0;
  
  private boolean initialized;
  private ScoreKeeper score;
  
  public void initialize() {
    new GameCreator().start();
    score = new ScoreKeeper();
  }

  class GameCreator extends Thread {
    public void run() {
      Phase[] phs = { new Phase1() };

      phases = toList(phs);
      for (Phase ph: phases) ph.initialize();

      initialized = true;
    }
  }

  public Phase getPhase() {
    return listGet(phases, phaseIndex, null);
  }
  
  public ScoreKeeper getScore() {
    return score;
  }

  public void execute() {
    switch (gameState) {
    case MAIN_MENU:
      menuState();
      break;
    case LOADING:
      loadingState();
      break;
    case RUNNING_PHASES:
      runningState();
      break;
    case GAME_COMPLETE:
      gameCompleteState();
      break;
    }
  }

  public void handleMouse(int x, int y) {
    switch (gameState) {
    case MAIN_MENU:
      gameState = GameState.RUNNING_PHASES;
      break;
    case LOADING:
      break;
    case RUNNING_PHASES:
      try {
        getPhase().getTest().getShape().tryClick(x, y);
      } catch(NullPointerException e) { /* No shape for user to click */ }
      break;
    case GAME_COMPLETE:
      gameCompleteState();
      break;
    }
  }

  private void menuState() {}
  private void loadingState() {
    initialize();
    gameState = GameState.RUNNING_PHASES;
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
    
    gameState = GameState.MAIN_MENU;
  }
}
