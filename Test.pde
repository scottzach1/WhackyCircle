class Test {

  private final int numOfCircles;
  private final TestAttr[] attributes;
  private ArrayList<Result> results;

  public Test(int numOfCircles, TestAttr[] attributes) {
    this.numOfCircles = numOfCircles;
    this.attributes = attributes;
    this.results = new ArrayList<Result>(); // Start of test will have no results
  }

  /*
  Run the test, this will not reset any variables. 
  Running the test more than once will continue to append more Results to "results".
  */
  public void run() {
    for (int c = 0; c < numOfCircles; ++c) {
      Point mouse = new Point(mouseX, mouseY);
    }
  }

  // immutable
  class Result {
    final Point mouse;
    final Circle circle;
    final ArrayList<Pair<Point, Long>> path; // point and timestamp

    public Result(Point m, Circle c, ArrayList<Pair<Point, Long>> p) {
      this.mouse = m;
      this.circle = c;
      this.path = p;
    }
  }
}
