/**
 User interface elements are ones which are used throughout
 menus, and not during gameplay. Gameplay elements have
 differnt properties to user interface components.
 */
abstract class UserInterfaceComponent {
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
    this.children.add(menu);
    this.children.add(rule);
    this.children.add(high);
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

  public boolean within() {
    return this.children.get(currentChild).within();
  }

  protected GameState onClick() {
    return this.children.get(currentChild).onClick();
  }

  protected void onScroll(int scroll){
    this.children.get(currentChild).onScroll(scroll);
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

  protected void onScroll(int scroll){
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        this.children.get(i).onScroll(scroll);
        return;
      }
    }
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
    //TODO: Get HighScores
    BulletParagraph bp = new BulletParagraph(new String[]{"Each game is made up of several phases."}, false);
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

  protected void onScroll(int scroll){
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        this.children.get(i).onScroll(scroll);
        return;
      }
    }
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

  protected void generateChildren() {
    //TODO: Get HighScores
    Button back = new Button(new Point(width / 2, height - 100), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "MAIN MENU");
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
    return GameState.HIGHSCORE;
  }

  protected void onScroll(int scroll){
    for (int i = 0; i < this.children.size(); ++i) {
      if (this.children.get(i).within()) {
        this.children.get(i).onScroll(scroll);
        return;
      }
    }
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
    text("HIGHSCORES", width / 2, 100);
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
    case "QUIT":
      exit();
    default :
      return GameState.MAIN_MENU;
    }
  }

  protected void onScroll(int scroll){/*Buttons don't scroll*/}

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
    textSize(size.y - 10);
    fill(s);
    text(text, pos.x, pos.y - 5);
  }

  protected void generateChildren() {/* No children for me (Leaf Node) */}
}

/**
BulletParagraph takes an array of strings and converts them into a nicely 
displayed paragraph.
 */
class BulletParagraph extends UserInterfaceComponent {
  private final String[] text;
  private final int TEXTS_ON_SCREEN = 4;
  private Point pos = new Point(width/2, height/2 + 20), size = new Point(width*2/3, height / 2);
  private int scrollFactor = 0;
  private boolean numberedPoints;

  BulletParagraph(String[] t, boolean numPts) {
    this.text = t;
    this.numberedPoints = numPts;
  }

  public boolean within() {
    return true && 
      inBoundsExcl(mouseX, pos.x - (size.x / 2), pos.x + (size.x / 2)) && 
      inBoundsExcl(mouseY, pos.y - (size.y / 2), pos.y + (size.y / 2));
  }


  protected GameState onClick() {/*Paragraphs shouldn't be actioned*/ return game.gameState;}

  protected void onScroll(int scroll){
    int sf = scrollFactor + scroll;
    if (0 <= sf && (sf + TEXTS_ON_SCREEN) <= text.length){
      scrollFactor = sf;
      }
  }

  public void render() {
    int tSize = (size.y / TEXTS_ON_SCREEN) - 20;
    textFont(createFont(FONT_SMALL,tSize));
    fill(200);
    for (int i = 0; (i < TEXTS_ON_SCREEN) && (i < text.length); ++i){
      int textY = (pos.y - size.y / 2) + ((tSize) * (i + 1));
      String curStr = text[(i + scrollFactor)];
      textAlign(LEFT, CENTER);
      if (numberedPoints)
      text((i + scrollFactor + 1) + " : " + curStr, pos.x - (size.x / 2) + 10, textY);
      else 
      text("> " + curStr, pos.x - (size.x / 2) + 10, textY);

    }
    textFont(createFont(FONT,tSize));
  }

  protected void generateChildren() {/* No children for me (Leaf Node) */}
}
