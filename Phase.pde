abstract class Phase {
  public boolean isDone;
  public Test curTest;
  
  protected ArrayList < Test > tests = new ArrayList();
  private int testIndex = 0;
  
  public void execute() {
    if (curTest != null) {
      curTest.execute();
      if (curTest.isDone) {
        next();
      }
    } else if (testIndex == 0) {
      next();
    } else {
      println("Current Test Undefined");
    }
  }
  
  private void next() {
    if (testIndex < tests.size()) {
      println(tests.get(testIndex));
      curTest = tests.get(testIndex);
    } else {
      isDone = true;
    }
    testIndex++;
  }
  
  public void initialize() { // Implement for each phase
    println("Phase Initialize Unimplemented");
  }
}

class Phase1 extends Phase {
  
  public void initialize() {
    this.tests.add(new Test1());
    this.tests.add(new Test1());

    for (Test t : this.tests){
      t.initialize();
    }
  }
  
}
