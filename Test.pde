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
  
  public Shape curShape;
  private int curIndex = 0;
  
  private Shape centreShape = new Square(new Point(displayWidth/4, displayHeight/4), 50);
  private long centreSince = -1;
  private boolean inCentre = false; // TODO: back to false when not testing

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
    if (!inCentre) {
        centreShape = new Square(new Point(displayWidth/4, displayHeight/4), 50); //Workaround for dw/dh being 0
        centreShape.render();
        
        if (centreShape.isHovering(new Point(mouseX, mouseY))){
          if (centreSince == -1) { // Just entered square, set time
            centreSince = millis();
          } else if (millis() - centreSince > 3000) { // Been in square, check if > 3 seconds
            inCentre = true;
          }
        } else { // Not in square
          centreSince = -1;
        }
    } else {
      attribute.execute();
      curShape.render();
      println(curShape.clicked);
    }
  }

  /**
  Set curShape to a new shape, and set inCentre to false, and set centreSince to -1;
  */
  public void next() {
    inCentre = false;
    centreSince = -1;
    curIndex++;
    curShape = attribute.shapes.get(curIndex);
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
