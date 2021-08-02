enum GameState {
  MAIN_MENU, 
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

    // New Score Keeper
    score = new ScoreKeeper();

    // Reset Phases
    phaseIndex = 0;
    Phase[] phs = { new Phase1()};
    phases = toList(phs);
    for (Phase ph : phases) ph.initialize();
    
    initialized = true;
  }

  class GameCreator extends Thread {
    public void run() {
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

  public void handleMouse(int x, int y) {
    switch(gameState) {
    case MAIN_MENU:
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

  private void menuState() {
    ui.toMainMenu();
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
    initialize();
    gameState = GameState.MAIN_MENU;
  }
}
