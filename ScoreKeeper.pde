class ScoreKeeper{
  private int overallScore;
  private int phaseScore;
  private ArrayList<Integer> phaseScores = new ArrayList();
  
  // Helpers for bounding box
  // Everything bases on font size
  private float fontSize = 35;
  private float rectW = fontSize * 10;
  private float rectH = fontSize * 3;
  private float rectL = width - rectW - 20;
  private float rectT = 20;
  
  ScoreKeeper() {
    overallScore = 0;
    phaseScore = 0;
  }
  
  public void displayScore() {
    rectMode(CORNER);
    fill(175);
    stroke(245);
    strokeWeight(5);
    rect(rectL, rectT, rectW, rectH, 10, 2, 10, 10);
    noStroke();
    
    fill(75);
    textAlign(CORNER);
    textFont(createFont(FONT, fontSize));
    text("Game Score:   " + overallScore, rectL + 10, rectT + (fontSize + 10));
    text("Phase Score:  " + phaseScore, rectL + 10, rectT + (fontSize + 10) * 2); // *2 because second line.
    fill(210);
  }
  
  public void updateScore(int update) {
    phaseScore += update;
    overallScore += update;
  }
  
  public void resetPhase() {
    phaseScores.add(phaseScore);
    phaseScore = 0;
  }

  public boolean outsideScoreBox(int sx, int sy, int r){
    return (sx + r > rectL) && (sy - r < rectT + rectH);
  }
  
  public ArrayList<Integer> getPhaseScores() {
    return new ArrayList(phaseScores);
  }
}
