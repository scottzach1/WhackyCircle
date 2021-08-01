/**
A Test object is used during a phase. Each phase consists of mulitple 
test objects, and every test object consists of multiple circles. 
Given a test attribute and number of circles to to draw, the 
test is responsible for executing the TestAttr, then generating a 
random circle.
*/
abstract class Test {
  
  private final int CENTER_HOLD_SECS = 1;
  
  protected ArrayList<Shape> shapes;
  protected ArrayList<Result> results;
  
  private int shapeIndex = 0;
  public boolean isDone;
  public Shape curShape;
  
  private Shape centreShape = new Square(new Point(displayWidth / 4, displayHeight / 4), 50);
  private long centreSince = -1;
  private boolean inCentre = false; // TODO: back to false when not testing
  
  public Test() {
    this.shapes = new ArrayList();
    this.results = new ArrayList(); // Start of test will have no results.
    this.initialize(); // Method to generate shapes for this test.
  }
  
  // Implement in solid classes
  public void initialize() {
    println("Unimplemented Test Initialize");
  }
  
  // Implement in solid classes  
  protected void preDrawSetup() {
    println("Unimplemented preDrawSetup");
  } 
  
  /**
  Run test will be run in the draw loop. Thus, this method can be considered 
  a loop. Thus, if statements can be used to alter the state of the 
  */
  public void execute() {
    preDrawSetup(); // Execture background an global changes
    if (!inCentre) {
      mouseCenter();
    } else {
      shapeShow();
    }
  }
  
  /**
  Displays an area in the center of the screen where the mouse must go before the next round.
  TODO: Display count down timer
  */
  private void mouseCenter() {
    centreShape = new Square(new Point(displayWidth / 4, displayHeight / 4), 50); //Workaround for dw/dh being 0
    centreShape.render();
    
    if (centreShape.isHovering(new Point(mouseX, mouseY))) {
      if (centreSince == -1) { // Just entered square, set time
        centreSince = millis();
      } else if ((millis() - centreSince) > (CENTER_HOLD_SECS * 1000)) { // Been in square, check if > 3 seconds
        inCentre = true;
      }
    } else { // Not in square
      centreSince = -1;
    }
  }
  
  /**
  Displays the current shape, and checks if the shape has been clicked.
  */
  private void shapeShow() {
    if (curShape != null) {
      curShape.render();
      if(curShape.clicked) {
        next();
      }
    } else if (shapeIndex == 0) {
      next();
    } else {
      println("Current Shape Undefined");
    }
  }
  
  /**
  Set curShape to a new shape, and set inCentre to false, and set centreSince to -1;
  */
  private void next() {
    inCentre = false;
    centreSince = -1;
    if (shapeIndex < this.shapes.size()) {
      curShape = this.shapes.get(shapeIndex);
      shapeIndex++;
    } else {
      isDone = true;
    }
  }
  
  // immutable
  class Result {
    final Point mouse; // On start 
    final Shape shape; // Circle that was clicked
    final ArrayList<Pair<Long, Point>> path; // timestamp and point
    
    public Result(Point m, Shape c, ArrayList<Pair<Long, Point>> p) {
      this.mouse = m;
      this.shape = c;
      this.path = p;
    }
  }
}



class Test1 extends Test {
  
  // Implement in solid classes
  public void initialize() {
    Shape[] ss = {
      new Circle(200, 150, 100),
        new Circle(20, 62, 25),
        new Circle(90, 100, 75)
      };
    this.shapes = toList(ss);
  }
  
  // Implement in solid classes  
  protected void preDrawSetup() {} 
}
