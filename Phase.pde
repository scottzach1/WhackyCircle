abstract class Phase {
  public Test curTest;
  public void execute() { 
    if (curTest != null) {
      curTest.run();
    } else {
      println("Current Test Undefined");
    }
  }
}

class Phase1 extends Phase {

  public Phase1() {
    this.curTest = new Test(new TestAttr() {

      {
        this.shapes = new ArrayList<Shape>(java.util.Arrays.asList(
          new Circle(new Point(50, 100), 50), 
          new Circle(new Point(200, 150), 100), 
          new Circle(new Point(20, 62), 25), 
          new Circle(new Point(90, 100), 75)
          ));
      }

      public void execute() {
      }
    }
    );
  }
}
