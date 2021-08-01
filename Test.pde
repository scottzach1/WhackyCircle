/**
A Test object is used during a phase. Each phase consists of mulitple 
test objects, and every test object consists of multiple circles. 
Given a test attribute and number of circles to to draw, the 
test is responsible for executing the TestAttr, then generating a 
random circle.
*/
abstract class Test {
  
  private final int CENTER_HOLD_SECS = 1;
  public static final int CENTRE_SIZE = 50;
  
  protected ArrayList<Shape> shapes;
  protected ArrayList<Result> results;
  
  private int shapeIndex = 0;

  private long centreSince = Long.MAX_VALUE;
  private boolean playerReady = false; // TODO(lckrist): back to false when not testing
  
  public Test() {
    this.shapes = new ArrayList();
    this.results = new ArrayList(); // Start of test will have no results.
    this.initialize(); // Method to generate shapes for this test.
  }
  
  // Implement in solid classes
  public void initialize() {
    println("WARN: " + getClassName(this, "Test") + " Init Unimplemented");
  }
  
  // Implement in solid classes  
  protected void preDrawSetup() {
    println("WARN: " + getClassName(this, "Test") + " PreDraw Unimplemented");
  }

  public Shape getShape() {
    return listGet(shapes, shapeIndex, null);
  }

  public boolean completedShapes() {
    return shapeIndex >= shapes.size();
  }
  
  /**
   * Run test will be run in the draw loop. Thus, this method can be considered 
   * a loop. Thus, if statements can be used to alter the state of the 
   */
  public void execute() {
    preDrawSetup(); // Execture background an global changes
    if (!playerReady) {
      mouseCentre();
    } else {
      shapeShow();
    }
  }
  
  /**
   * Displays an area in the centre of the screen where the mouse must go before the next round.
   * TODO: Display count down timer
   */
  private void mouseCentre() {
    Shape centreShape = new Square(width / 2 - CENTRE_SIZE, height / 2 - CENTRE_SIZE, CENTRE_SIZE);
    centreShape.render();

    if (!centreShape.within(mouseX, mouseY)) {
      centreSince = Long.MAX_VALUE; // Not in square.
    }

    centreSince = Math.min(centreSince, millis());

    // Check if been in square > CENTER_HOLD_SECS seconds.
    if ((millis() - centreSince) > (CENTER_HOLD_SECS * 1000)) {
      playerReady = true;
    }
  }
  
  /**
  Displays the current shape, and checks if the shape has been clicked.
  */
  private void shapeShow() {
    if (completedShapes()) return;

    Shape s = getShape();

    if (s == null) {
      println("WARN: Current Shape Undefined");
      return;
    }

    s.render();

    if (s.hasBeenClicked()) {
      playerReady = false;
      ++shapeIndex;
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
// processing-core-PApplet

ShapeBuilder builder = new ShapeBuilder();

class Test1 extends Test {
  
  // Implement in solid classes
  public void initialize() {
    this.shapes = builder.addType(ShapeType.CIRCLE).times(3).toList();
  }
  
  // Implement in solid classes  
  protected void preDrawSetup() {} 
}
