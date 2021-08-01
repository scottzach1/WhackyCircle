enum GameState {
  MAIN_MENU,
  LOADING,
  RUNNING_PHASES,
  GAME_COMPLETE
}

class Game {
  private GameState gameState = GameState.RUNNING_PHASES;

  private ArrayList<Phase>phases;
  private int phaseIndex = 0;
  
  private boolean initialized;

  public void initialize() {
    new GameCreator().start();
  }

  class GameCreator extends Thread {
    public void run() {
      Phase[] phs = { new Phase1(), new Phase1() };

      phases = toList(phs);
      for (Phase ph: phases) ph.initialize();

      initialized = true;
    }
  }

  public Phase getPhase() {
    return listGet(phases, phaseIndex, null);
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

  private void menuState() {}
  private void loadingState() {}

  private void runningState() {
    if (!initialized) return;

    Phase p = getPhase();

    if (p == null) {
      println("WARN: Current Phase Undefined");
      return;
    }

    p.execute();

    if (p.completedTests()) ++phaseIndex;
    if (phaseIndex == phases.size()) gameState = GameState.GAME_COMPLETE;
  }

  private void gameCompleteState() {
    println("Game Complete :party-parrot:");
    gameState = GameState.MAIN_MENU;
  }
}