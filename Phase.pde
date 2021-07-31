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
      public ArrayList<Shape> shapes = new ArrayList();
      public void execute() {
      }
    }
    );
  }
}
