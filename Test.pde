class Test {

  private final int numOfCircles;
  private final TestAttr attribute;
  private ArrayList<Result> results;

  public Test(int numOfCircles, TestAttr attribute) {
    this.numOfCircles = numOfCircles;
    this.attribute = attribute;
    this.results = new ArrayList<Result>(); // Start of test will have no results
  }

  /**
   * Run the test, this will not reset any variables. 
   * Running the test more than once will continue to append more Results to "results".
   */
  public void run() { 
    for (int c = 0; c < numOfCircles; ++c) {
      // Get mouse to center ----
      Point mouse = new Point(mouseX, mouseY);
    }
  }

  // immutable
  class Result {
    final Point mouse; // On start 
    final Circle circle; // Circle that was clicked
    final ArrayList<Pair<Long, Point>> path; // timestamp and point

    public Result(Point m, Circle c, ArrayList<Pair<Point, Long>> p) {
      this.mouse = m;
      this.circle = c;
      this.path = p;
    }
  }
}
