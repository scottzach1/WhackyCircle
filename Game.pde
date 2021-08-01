enum GameState {
  MAIN_MENU, LOADING, RUNNING_PHASES
}

class Game {
  private boolean initialized;
  private GameState gameState = GameState.RUNNING_PHASES;
  private ArrayList<Phase> phases;
  private int phaseIndex = 0;

  public Phase curPhase = new Phase1();

  public void initialize() {
    new GameCreator().start();
  }

  class GameCreator extends Thread {    
    public void run() {
      phases = new ArrayList();
      phases.add(new Phase1());
      phases.add(new Phase1());

      for (Phase ph : phases) {
        ph.initialize();
      }
      initialized = true;
    }
  } 

  public void execute() {
    switch(gameState) {
    case MAIN_MENU:
      // TODO:
      break;
    case LOADING:
      //TODO:
      break;
    case RUNNING_PHASES:
      if (initialized) {
        if (curPhase != null) {
          curPhase.execute();
          if (curPhase.isDone) {
            next();
          }
        } else if (phaseIndex == 0) {
          next();
        } else {
          println("Current Phase Undefined");
        }
      }
      break;
    }
  }


  public void next(){
    if (phaseIndex < phases.size()) {
      curPhase = phases.get(phaseIndex);
    } else {
      println("WOOHOO");
    }
    phaseIndex++;
  }
}
