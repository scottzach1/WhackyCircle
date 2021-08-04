enum GameState {
  MAIN_MENU, 
  RULES, 
  HIGHSCORE, 
  RUNNING_PHASES,
  GAME_FINISHED, 
  GAME_COMPLETE
}

class Game {
  private GameState gameState = GameState.MAIN_MENU;
  private GameUserInterface ui;

  private ArrayList < Phase > phases;
  private int phaseIndex = 0;

  private boolean initialized;
  private ScoreKeeper score;

  public void initialize() { 
    ui = new GameUserInterface();
    new AssetLoader().start();

    // New Score Keeper
    score = new ScoreKeeper();

    // Reset Phases
    phaseIndex = 0;
    Phase[] phs = {new Phase0(), new Phase1(), new Phase2(), new Phase3(), new Phase4()};
    phases = toList(phs);
    for (Phase ph: phases) ph.initialize();

    initialized = true;
  }

  class AssetLoader extends Thread {
    public void run() {
      sb = importScoreBoard();
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
    switch (gameState) {
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
    case GAME_FINISHED:
      gameFinishedState();
      break;
    case GAME_COMPLETE:
      gameCompleteState();
      break;
    }
  }

  public void handleMouseClick(int x, int y) {
    switch (gameState) {
    case MAIN_MENU:
    case RULES:
    case HIGHSCORE:
    case GAME_FINISHED:
      gameState = ui.onClick();
      break;
    case RUNNING_PHASES:
      try {
        getPhase().getTest().getShape().tryClick(x, y);
      } catch (NullPointerException e) {
        /* No shape for user to click */
      }
      break;
    }
  }

  public void handleMouseWheel(int scroll) {
    ui.onScroll(scroll);
  }

  public void handleKeyPress(Character c){
    ui.onKey(c);
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

  private void gameFinishedState() {
    ui.toFinalScreen();
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
    score.displayScore(phaseIndex);

    if (p.completedTests()) {
      ++phaseIndex;
      score.resetPhase();
    }
    if (phaseIndex == phases.size()) gameState = GameState.GAME_FINISHED;
  }

  private GameSaver gs = null;

  private void gameCompleteState() {
    println("Game Complete :party-parrot:");
    ui.toFinalScreen();
    ui.render();
    if (gs != null && gs.isDone()){
      gs = null;
      initialize();
      gameState = GameState.MAIN_MENU;
    } else if (gs == null){
      gs = new GameSaver();
      gs.start();
    }
  }

  class GameSaver extends Thread{
    private boolean done = false;

    @Override
    public void run(){
      saveMetrics();
      done = true;
    }

    public boolean isDone(){
      return done;
    }
  }


  private void saveMetrics() {
    TestVisitor[] visitors = {
      new AverageDistanceFromCenter(),
      new FittzVisitor(),
      new ResponseTimeVisitor(),
      new ActionTimeVisitor(),
      new TimeToClickVisitor()
    };

    UUID uuid = UUID.randomUUID();

    ArrayList < MetricRow > metrics = new ArrayList();

    int phaseId = -1;
    for (Phase p: phases) {
      MetricRow metric = new MetricRow(userName, ++phaseId, uuid);

      for (TestVisitor v: visitors) {
        String metricKey = v.metricKey();
        
        long averageValue = 0L;
        for (Test t: p.getTests()) averageValue += t.accept(v);
        averageValue = averageValue / (long) p.getTests().size();

        metric.metrics.put(metricKey, averageValue);
      }
      metrics.add(metric);
    }

    sb.sumbitScore(new ScoreEntry(userName, score.getOverallScore()));
    sb.save();
    saveMetricsToFile(metrics, uuid, userName);
    saveGamePaths(phases, uuid, userName);
    
    // Reset the Score keeper
    score = new ScoreKeeper();
  }
}
