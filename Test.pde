/**
 A Test object is used during a phase. Each phase consists of mulitple 
 test objects, and every test object consists of multiple circles. 
 Given a test attribute and number of circles to to draw, the 
 test is responsible for executing the TestAttr, then generating a 
 random circle.
 */
abstract class Test {

  private int currentCenterHoldSec = 1000;
  private int shapeAvoidanceSec = 3000;
  
  public static final int CENTRE_SIZE = 50;

  protected ArrayList<Shape> shapes;
  protected ArrayList<Result> results;

  private int shapeIndex = 0;
  private int resultIndex = 0;

  private long centreSince = Long.MAX_VALUE;
  private long avoidanceSince = Long.MAX_VALUE;

  private boolean playerReady = false; // TODO(lckrist): back to false when not testing

  public Test() {
    this.shapes = new ArrayList();
    this.results = new ArrayList(); // Start of test will have no results.
    this.initialize(); // Method to generate shapes for this test.
  }

  public abstract Long accept(TestVisitor visitor); 

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
    if (playerReady) {
      shapeShow();
    } else {
      mouseCentre();
    }
  }

  /**
   * Displays an area in the centre of the screen where the mouse must go before the next round.
   * TODO: Display count down timer
   */
  private void mouseCentre() {
    Shape centreShape = new Image(centerMouse, width / 2, height / 2, CENTRE_SIZE);
    centreShape.render();

    if (!centreShape.within(mouseX, mouseY)) {
      centreSince = Long.MAX_VALUE; // Not in square.
    }

    centreSince = Math.min(centreSince, millis());
    // Check if been in square > CENTER_HOLD_SECS seconds.

    if ((millis() - centreSince) > (currentCenterHoldSec)) {
      newResult();
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
    
    if (s instanceof Square) {
      avoidanceSince = Math.min(avoidanceSince, millis());
    }
    
    if (s.hasBeenClicked() || (millis() - avoidanceSince) > (shapeAvoidanceSec)) {
      nextResult();
      game.getScore().updateScore(results.get(resultIndex - 1).getScore());
      playerReady = false;
      ++shapeIndex;
    }
  }


  /**
  If the index doesn't exist, add a new Result. 
  Else, a result for this shape has already been generated.
  */
  private void newResult() {
    if (resultIndex >= results.size()){
      avoidanceSince = Long.MAX_VALUE;
      centreSince = Long.MAX_VALUE;
      if (!(this instanceof Test1)) {
        currentCenterHoldSec = randomInt(1000, 4000);
      }
      results.add(new Result());
      pt.start();
    }
  }

  /**
  If the current index contains an object, then set the path of that object,
  and increment the resultIndex such that we are outside the Index Bounds.
  Thus, calling nextResult again will not work, and newResult will.
  */
  private void nextResult() {
    if (resultIndex < results.size()) {
      results.get(resultIndex).setPath();
      resultIndex++;
    }
  }

  public ArrayList<Result> getResults() {
    return new ArrayList(results); // Encapsulate results
  }

  // immutable
  class Result {
    private Point mouse; // On start 
    private Shape shape; // Circle that was clicked
    private ArrayList<Pair<Long, Point>> path; // timestamp and point

    public Result() {
      this.mouse = new Point(mouseX, mouseY); // Encapsulation
      Shape s = shapes.get(shapeIndex);
      this.shape = s; // Encapsulation
    }

    public void setPath() {
      path = pt.stop();
    }

    public Point getStartingMouse() {
      return mouse;
    }

    public float getDist(){
      return mouse.distanceFrom(shape.p);
    }

    public int getScore(){
      float distToCenter = shape.p.distanceFrom(new Point(mouseX, mouseY));

      float dist = getDist();
      float time = path.get(path.size()-1).left - path.get(0).left;
      float velocity = dist/(time/1000); // Pixels per second

      if (distToCenter == 0) distToCenter = 0.01;
      float points = velocity / (distToCenter * 10);
      points = Math.round(points);
      if (shape instanceof Square) points = -points;
      return (int) points;
    }

    public Shape getShape(){
      return this.shape;
    }

    public ArrayList<Pair<Long, Point>> getPath(){
      return new ArrayList(path);
    }

    long getActionTimestamp() {
      long startTimestamp = path.get(0).left;
      Point startPoint = path.get(0).right;
      
      long actionTimestamp = 0L;

      int i = 0;
      for (Pair<Long, Point> pair : path) {
          ++i;
          // get the first timestamp the point changed.
          if (startPoint.equals(pair.right)) {
              actionTimestamp = Math.max(pair.left, actionTimestamp);
          }
      }

      return actionTimestamp;
    }

    long getResponseTime() {
      long startTimestamp = path.get(0).left;

      return getActionTimestamp() - startTimestamp;
    }

    long getActionTime() {
      long endTimestamp = path.get(path.size() - 1).left;

      return endTimestamp - getActionTimestamp();
    }

    long getFittz() {
      float distanceToTarget = getDist();
      float widthOfTarget = float(shape.r);
      
      return getResponseTime() + getActionTime() * (log2(1 + (long) (distanceToTarget / widthOfTarget)));
    }
  }
}

ShapeBuilder builder = new ShapeBuilder();

class Test1 extends Test {

  // Implement in solid classes
  public void initialize() {
    this.shapes = builder.addType(ShapeType.CIRCLE).times(5).toList();
  }

  // Implement in solid classes  
  protected void preDrawSetup() {
  }

  public Long accept(TestVisitor visitor) {
    return visitor.acceptTest(this);
  }
}

class Test2 extends Test {

  // Implement in solid classes
  public void initialize() {
    this.shapes = builder.addType(ShapeType.CIRCLE).times(5).toList();
  }
  
  // Implement in solid classes  
  protected void preDrawSetup() {
  }

  public Long accept(TestVisitor visitor) {
    return visitor.acceptTest(this);
  }
}

class Test3 extends Test {

    // Implement in solid classes
  public void initialize() {
    this.shapes = builder.addTypes(ShapeType.values()).times(5).toList();
  }
  
  // Implement in solid classes  
  protected void preDrawSetup() {
  }

  public Long accept(TestVisitor visitor) {
    return visitor.acceptTest(this);
  }
}

class Test4 extends Test {
  ArrayList <MovingCircle> circles;
  color c;
  
  // Implement in solid classes
  public void initialize() {
    this.shapes = builder.addTypes(ShapeType.values()).times(5).toList();
     
    circles = new ArrayList();
    for(int i = 0; i < 6; i++) {
      Point p = new Point(randomInt(0, displayWidth), randomInt(0, displayHeight));
      c = color(randomInt(100, 255), randomInt(100, 255), randomInt(100, 255));
      int x = randomInt(-3,3);
      int y = randomInt(-3,3);
      x = (x == 0 && y == 0) ? -1 : x;
      circles.add(new MovingCircle(p, randomInt(20, 200), x, y, c));
    }
  }
  
  
  // Implement in solid classes  
  protected void preDrawSetup() {
   
   
   ArrayList <MovingCircle> update = new ArrayList();

   for (MovingCircle circle: circles){
     fill(circle.c);
     circle.render();
     
     if(circle.p.x < 0 || circle.p.x > displayWidth) circle.directionX *= -1;
     if(circle.p.y < 0 || circle.p.y > displayHeight) circle.directionY *= -1;

     update.add(new MovingCircle(circle.p.x + circle.directionX, circle.p.y + circle.directionY, circle.r, circle.directionX, circle.directionY, circle.c));
   }
   circles = update; 
   fill(210);
  }

   public Long accept(TestVisitor visitor) {
    return visitor.acceptTest(this);
  }
}
