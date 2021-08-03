/**
 User interface elements are ones which are used throughout
 menus, and not during gameplay. Gameplay elements have
 differnt properties to user interface components.
 */
abstract class UserInterfaceComponent {
  public String userName = "";
  protected ArrayList<UserInterfaceComponent> children;
  protected final String FONT =  "FiraSansCondensed-Bold.ttf";
  protected final String FONT_SMALL =  "FiraSansCondensed-Light.ttf";

  UserInterfaceComponent() {
    children = new ArrayList();
    generateChildren();
  }

  // IMPLEMENT ME!
  public abstract boolean within();
  protected abstract GameState onClick();
  protected abstract void onScroll(int scroll);
  protected abstract void onKey(Character c);
  public abstract void render();
  protected abstract void generateChildren();
}

public float getTextSize(Point size, String str) {
  // calculate minimum size to fit width
  float minSizeW = 12 / textWidth(str) * size.x;
  // calculate minimum size to fit height
  float minSizeH = 12 / (textDescent() + textAscent()) * size.y;
  return min(minSizeW, minSizeH);
}

/**
 A wrapper user interface to encompass all other menu elements. 
 Allows for one gateway to render all pages.
 */
class GameUserInterface extends UserInterfaceComponent {
  private int currentChild = 0;

  protected void generateChildren() {
    UserInterfaceComponent menu = new MainMenu();
    UserInterfaceComponent rule = new Rules();
    UserInterfaceComponent high = new HighScore();
    UserInterfaceComponent fins = new FinalGameScreen();
    this.children.add(menu);
    this.children.add(rule);
    this.children.add(high);
    this.children.add(fins);
  }

  public void toMainMenu() { 
    currentChild = 0;
  }

  public void toRules() { 
    currentChild = 1;
  }

  public void toHighScore() { 
    currentChild = 2;
  }

  public void toFinalScreen() { 
    currentChild = 3;
  }

  public boolean within() {
    return this.children.get(currentChild).within();
  }

  protected GameState onClick() {
    return this.children.get(currentChild).onClick();
  }

  protected void onScroll(int scroll) {
    this.children.get(currentChild).onScroll(scroll);
  }

  protected void onKey(Character c) {
    if (currentChild == 3)
      this.children.get(currentChild).onKey(c);
  }

  public void render() { 
    this.children.get(currentChild).render();
  }
}

/**
 MainMenu shows the title along with play, highscore, rules and quit buttons.
 */
class MainMenu extends UserInterfaceComponent {

  protected void generateChildren() {
    int buttonStartHeight = height / 2 - 75;
    Button play = new Button(new Point(width / 2, buttonStartHeight), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "PLAY");   
    Button rule = new Button(new Point(width / 2, buttonStartHeight + 100), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "RULES");   
    Button score = new Button(new Point(width / 2, buttonStartHeight + 200), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "HIGHSCORE");   
    Button quit = new Button(new Point(width / 2, buttonStartHeight + 300), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "QUIT");  
    this.children.add(play);
    this.children.add(rule);
    this.children.add(score);
    this.children.add(quit);
  }

  public boolean within() {
    return true;
  }

  protected GameState onClick() {
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        return this.children.get(i).onClick();
      }
    }
    return GameState.MAIN_MENU;
  }

  protected void onScroll(int scroll) {
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        this.children.get(i).onScroll(scroll);
        return;
      }
    }
  }

  protected void onKey(Character c) {
    // Does nothing
  }

  public void render() {
    background(55);
    renderTitle();
    for (int i = 0; i < this.children.size(); ++i) {
      this.children.get(i).render();
    }
  }

  private void renderTitle() {
    textAlign(CENTER, CENTER);
    textFont(createFont(FONT, height / 4));
    fill(0);
    text("WHACKY CIRCLE", width / 2, 100);
  }
}

/**
 Highscore is used to present players with the top ten scores. 
 */
class Rules extends UserInterfaceComponent {

  protected void generateChildren() {
    BulletParagraph bp = new BulletParagraph(new String[]{
      "Each game is made up of several phases,", 
      "with each phase having some slight variation", 
      "from the last. At the start of a game hold", 
      "your mouse in the centre of the screen (indicated", 
      "by the white circle with a cursor and timer image.", 
      "After some period of time, the center circle will", 
      "disappear, and another circle will be on screen.", 
      "Your task, is to try click this appearing circle", 
      "as fast as possible.", 
      }, false);
    Button back = new Button(new Point(width / 2, height - 100), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "MAIN MENU");
    this.children.add(bp);
    this.children.add(back);
  }

  public boolean within() {
    return true;
  }

  protected GameState onClick() {
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        return this.children.get(i).onClick();
      }
    }
    return GameState.RULES;
  }

  protected void onScroll(int scroll) {
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        this.children.get(i).onScroll(scroll);
        return;
      }
    }
  }

  protected void onKey(Character c) {
    // Does nothing
  }

  public void render() {
    //TODO: Render HighScores
    background(55);
    renderTitle();
    for (int i = 0; i < this.children.size(); ++i) {
      this.children.get(i).render();
    }
  }

  private void renderTitle() {
    textAlign(CENTER, CENTER);
    textFont(createFont(FONT, height / 4));
    fill(0);
    text("RULES", width / 2, 100);
  }
}

/**
 Highscore is used to present players with the top ten scores. 
 */
class HighScore extends UserInterfaceComponent {
  private HighScoreLoader hsl;  

  protected void generateChildren() {
    BulletParagraph bp = new BulletParagraph(new String[]{"Loading high scores..."}, true);
    Button back = new Button(new Point(width / 2, height - 100), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "MAIN MENU");
    this.children.add(bp);
    this.children.add(back);
    hsl = new HighScoreLoader();
    hsl.start();
  }

  public boolean within() {
    return true;
  }

  protected GameState onClick() {
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        return this.children.get(i).onClick();
      }
    }
    return GameState.HIGHSCORE;
  }

  protected void onScroll(int scroll) {
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        this.children.get(i).onScroll(scroll);
        return;
      }
    }
  }

  protected void onKey(Character c) {
    // Does nothing
  }

  public void render() {
    background(55);
    renderTitle();
    for (int i = 0; i < this.children.size(); ++i) {
      this.children.get(i).render();
    }
    if (hsl.update()) {
      this.children.set(0, new BulletParagraph(hsl.getContents(), true));
    }
  }

  class HighScoreLoader extends Thread {
    private boolean update = false;
    private String[] contents;
    private ArrayList<String> oldHighScores = new ArrayList();

    public void run() {

      while (!this.isInterrupted()) {
        boolean u = false;

        if (sb == null) continue;

        ArrayList<String> highScores = new ArrayList();
        ArrayList<ScoreEntry> highScoreEntries = new ArrayList(sb.highScores);

        for (ScoreEntry se : highScoreEntries) {
          highScores.add(se.name + " : " + se.score);
        }

        if (highScores.size() > oldHighScores.size())
          u = true;
        else
          for (int i = 0; i < highScores.size(); ++i)
            if (!highScores.get(i).equals(oldHighScores.get(i))) { 
              u = true; 
              break;
            }

        if (u) {
          oldHighScores = highScores;
          contents = new String[oldHighScores.size()];
          for (int i = 0; i < oldHighScores.size(); ++i) contents[i] = oldHighScores.get(i);
          update = true;
        }
      }
    }

    public boolean update() {
      boolean oldUpdate = update;
      update = false;
      return oldUpdate;
    }

    public String[] getContents() {
      return contents;
    }
  }

  private void renderTitle() {
    textAlign(CENTER, CENTER);
    textFont(createFont(FONT, height / 4));
    fill(0);
    text("HIGHSCORES", width / 2, 100);
  }
}

class FinalGameScreen extends UserInterfaceComponent {
  private ArrayList<Character> cs;
  private int dots = 0;
  private int lastDot = 0;

  protected void generateChildren() { 
    cs = new ArrayList();
    Button back = new Button(new Point(width / 2, height - 100), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "SUBMIT");
    this.children.add(back);
  }

  public boolean within() {
    return true;
  }

  protected GameState onClick() {
    if (cs.size() == 3)
      for (int i = 0; i < this.children.size(); ++i)
        if (this.children.get(i).within())
          return this.children.get(i).onClick();
    return GameState.GAME_FINISHED;
  }

  protected void onScroll(int scroll) {/*NOTHING*/
  }

  protected void onKey(Character c) {
    if (c == '`') {if (cs.size() == 3) {game.gameState = GameState.GAME_COMPLETE;}}
    else if (c == '-') {cs.remove(cs.size() - 1);}
    else if (cs.size() <= 3) {cs.add(c);}
  }

  public void render() {
    background(55);
    renderTitle();
    if (game.gameState == GameState.GAME_COMPLETE) {
      renderDots();
    } else {
      for (int i = 0; i < this.children.size(); ++i) {
        renderChars();
        this.children.get(i).render();
      }
    }
  }

  private void renderTitle() {
    textAlign(CENTER, CENTER);
    textFont(createFont(FONT, height / 4));
    fill(0);
    text("FINISHED", width / 2, 100);
  }

  private void renderDots(){
    textAlign(CENTER, CENTER);
    textFont(createFont(FONT, height / 4));
    fill(0);
    String str = "";
    for (int i = 0; i < dots; ++i){
      str += ".";
    }
    if (millis() - lastDot > 1000){
      dots = (dots + 1) % 5;
      lastDot = millis();
    }
    text(str, width / 2, height / 2);
  }

  private void renderChars(){
    textAlign(CENTER, CENTER);
    textFont(createFont(FONT_SMALL, height / 8));
    fill(0);
    text("Enter your initials:", width / 2, 250);

    // Chars
    int rectSize = height/6;
    fill(100);
    rectMode(CENTER);
    textFont(createFont(FONT, rectSize));
    for(int i = 0; i < 3; i++){
      int x = width / 2 + ((rectSize + 30) * (i-1));
      int y = height*2/3;
      fill(100);
      rect(x, y, rectSize, rectSize);
      if(i < cs.size()){
        fill(0);
        text(cs.get(i) + "", x, y - 10);
      }
    }
  }
}

/**
 A main component for any page, buttons are hardcoded to interact with
 the rest of the game system.
 */
class Button extends UserInterfaceComponent {
  private final String text;
  private final Point pos, size;
  private final color stroke, fill;

  Button(Point p, Point s, color stroke, color fill, String t) {
    super();
    this.pos = p;
    this.size = s;
    this.stroke = stroke;
    this.fill = fill;
    this.text = t;
  }

  public boolean within() {
    return true && 
      inBoundsExcl(mouseX, pos.x - (size.x / 2), pos.x + (size.x / 2)) && 
      inBoundsExcl(mouseY, pos.y - (size.y / 2), pos.y + (size.y / 2));
  }


  protected GameState onClick() {
    switch (text) {
    case "PLAY":
      return GameState.RUNNING_PHASES;
    case "RULES":
      return GameState.RULES;
    case "HIGHSCORE":
      return GameState.HIGHSCORE;
    case "SUBMIT":
      return GameState.GAME_COMPLETE;
    case "QUIT":
      exit();
    default :
      return GameState.MAIN_MENU;
    }
  }

  protected void onScroll(int scroll) {/*Buttons don't scroll*/
  }

  protected void onKey(Character c) {
    // Does nothing
  }

  public void render() {
    color s = stroke, f = fill;
    if (within()) {
      f = color(207, 238, 252);
    }
    rectMode(CENTER);
    stroke(s);
    fill(f);
    strokeWeight(5);
    rect(pos.x, pos.y, size.x, size.y, 10);
    strokeWeight(1);
    textAlign(CENTER, CENTER);
    textFont(createFont(FONT, size.y - 10));
    fill(s);
    text(text, pos.x, pos.y - 5);
  }

  protected void generateChildren() {/* No children for me (Leaf Node) */
  }
}

/**
 BulletParagraph takes an array of strings and converts them into a nicely 
 displayed paragraph.
 */
class BulletParagraph extends UserInterfaceComponent {
  public final String[] text;
  private Point pos = new Point(width/2, height/2 + 20), size = new Point(width*2/3, height / 2);
  private int scrollFactor = 0;
  private boolean numberedPoints;
  private int tSize = 5; 

  BulletParagraph(String[] t, boolean numPts) {
    this.text = t;
    this.numberedPoints = numPts;

    String longestText = "";
    for (int i = 0; i < text.length; ++i) if (text[i].length() > longestText.length()) longestText = text[i];
    textFont(createFont(FONT_SMALL, tSize));
    tSize = 5;
    while (tSize < 1000) {
      textFont(createFont(FONT_SMALL, tSize));
      if (textWidth(longestText) < size.x) tSize++;
      else break;
    }
    tSize = Math.min((size.y / 6), tSize);
  }

  public boolean within() {
    return true && 
      inBoundsExcl(mouseX, pos.x - (size.x / 2), pos.x + (size.x / 2)) && 
      inBoundsExcl(mouseY, pos.y - (size.y / 2), pos.y + (size.y / 2));
  }


  protected GameState onClick() {/*Paragraphs shouldn't be actioned*/
    return game.gameState;
  }

  protected void onScroll(int scroll) {
    int sf = scrollFactor + scroll;
    if (0 <= sf && sf < text.length) {
      scrollFactor = sf;
    }
  }

  protected void onKey(Character c) {
    // Does nothing
  }

  public void render() {
    fill(200);
    textFont(createFont(FONT_SMALL, tSize));
    int i = 0;
    int textY = 0;
    for (i = 0; (i + scrollFactor) < text.length; ++i) {

      textY = (pos.y - size.y / 2) + ((tSize) * (i + 1));
      if (textY > pos.y + (size.y / 2) - tSize) break;

      String curStr = text[(i + scrollFactor)];
      textAlign(LEFT, CENTER);
      if (numberedPoints)
        text((i + scrollFactor + 1) + " : " + curStr, pos.x - (size.x / 2) + 10, textY);
      else 
      text("> " + curStr, pos.x - (size.x / 2) + 10, textY);
    }
    if (i + scrollFactor < text.length) text("...", pos.x - (size.x / 2) + 10, textY);
  }

  protected void generateChildren() {/* No children for me (Leaf Node) */
  }
}
