/**
 User interface elements are ones which are used throughout
 menus, and not during gameplay. Gameplay elements have
 differnt properties to user interface components.
 */
abstract class UserInterfaceComponent {
  protected ArrayList<UserInterfaceComponent> children;
  protected String font =  "Fira Sans Condensed Bold";

  UserInterfaceComponent() {
    children = new ArrayList();
    generateChildren();
  }

  // IMPLEMENT ME!
  public abstract boolean within();
  protected abstract GameState onClick();
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

  public void render() {
    background(55);
    renderTitle();
    for (int i = 0; i < this.children.size(); ++i) {
      this.children.get(i).render();
    }
  }

  private void renderTitle() {
    textAlign(CENTER, CENTER);
    textFont(createFont(font, height / 4));
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
    Button back = new Button(new Point(width / 2, height - 100), new Point(width / 3, 75), color(145, 145, 145), color(102, 207, 255, 50), "MAIN MENU");
    this.children.add(back);
  }

  public boolean within() {
    return true;
  }

  protected GameState onClick() {
    if (this.children.get(0).within()) return GameState.MAIN_MENU;
    return GameState.RULES;
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
    textFont(createFont(font, height / 4));
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
    if (this.children.get(0).within()) return GameState.MAIN_MENU;
    return GameState.HIGHSCORE;
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
    textFont(createFont(font, height / 4));
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
  private final Point pos, size;

  BulletParagraph(Point p, Point s, String[] t) {
    this.pos = p;
    this.size = s;
    this.text = t;
  }

  public boolean within() {
    return true && 
      inBoundsExcl(mouseX, pos.x - (size.x / 2), pos.x + (size.x / 2)) && 
      inBoundsExcl(mouseY, pos.y - (size.y / 2), pos.y + (size.y / 2));
  }


  protected GameState onClick() {/*Paragraphs shouldn't be actioned*/ return game.gameState;}

  public void render() {
  }

  protected void generateChildren() {/* No children for me (Leaf Node) */}
}
