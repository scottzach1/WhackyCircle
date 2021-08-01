enum GameState {
  MAIN_MENU,
  LOADING,
  RUNNING_PHASES
}

class Game {
  private boolean initialized;
  private GameState gameState = GameState.RUNNING_PHASES;
  private ArrayList < Phase > phases;
  private int phaseIndex = 0;

  public Phase curPhase = new Phase1();

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
    }
  }

  public void next() {
    if (phaseIndex < phases.size()) {
      curPhase = phases.get(phaseIndex);
    } else {
      println("Game Complete 🥳");
    }
    phaseIndex++;
  }

  private void menuState() {}
  private void loadingState() {}

  private void runningState() {
    if (!initialized) return;

    if (curPhase != null) {
      curPhase.execute();
      if (curPhase.isDone) {
        next();
      }
    } else if (phaseIndex == 0) {
      next();
    } else {
      println("WARN: Current Phase Undefined");
    }
  }
}
