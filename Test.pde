/**
 Test Attribute executes before every circle is drawn.
 This will provide the functional difference between tests.
 */
abstract class TestAttr {
  public ArrayList<Shape> shapes;

  public void execute() {
    println("Unimplemented Attr");
  }
}

/**
 A Test object is used during a phase. Each phase consists of mulitple 
 test objects, and every test object consists of multiple circles. 
 Given a test attribute and number of circles to to draw, the 
 test is responsible for executing the TestAttr, then generating a 
 random circle.
 */
class Test {

  private final TestAttr attribute;
  private ArrayList<Result> results;
  public Shape curShape = new Circle(new Point(100, 100), 100);
  
  private int curIndex = 0;
  private boolean inCenter = true; // TODO: back to false when not testing

  public Test(TestAttr attribute) {
    this.attribute = attribute;
    this.results = new ArrayList<Result>(); // Start of test will have no results
  }

  /**
  Run test will be run in the draw loop. Thus, this method can be considered 
  a loop. Thus, if statements can be used to alter the state of the 
   */
  public void run() {
    attribute.execute();
    if (!inCenter) {
      // Start the stage by running a check to see if the mouse is in the
      // center of the screen for three seconds. Check seconds with time differences
      // need to use a field to store
    } else {
      attribute.execute();
      curShape.render();
      println(curShape.clicked);
    }
  }

  /**
  Set curShape to a new shape, and set inCenter to false;
  */
  public void next() {
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
