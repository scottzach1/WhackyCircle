class ScoreKeeper{
  private int overallScore;
  private int phaseScore;
  
  ScoreKeeper() {
    overallScore = 0;
    phaseScore = 0;
  }
  
  public void displayScore() {
    rectMode(CORNER);
    rect(5, 5, 120, 50, 10, 10, 10, 10);

    fill(0);
    text("Game Score: " + overallScore, 20, 20);
    text("Phase Score: " + phaseScore, 20, 40);
    fill(255);
  }
  
  public void updateScore(int update) {
    phaseScore += update;
    overallScore += update;
  }
  
  public void resetPhase(){
    phaseScore = 0;
  }
}
