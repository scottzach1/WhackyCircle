abstract class Phase {
  protected ArrayList <Test> tests = new ArrayList();
  private int testIndex = 0;
  
  public void execute() {
    if (completedTests()) return;

    Test t = getTest();

    if (t == null) {
      println("WARN: Current Test Undefined");
      return;
    }

    t.execute();

    if (t.isDone) ++testIndex;
  }

  public boolean completedTests() {
    return testIndex >= tests.size();
  }

  public Test getTest() {
    return listGet(tests, testIndex, null);
  }
  
  public void initialize() { // Implement for each phase
    println("WARN: " + this.getClass().getSimpleName() + " Initialize Unimplemented");
  }
}

class Phase1 extends Phase {
  
  public void initialize() {
    Test[] ts = {new Test1(), new Test1()};
    
    this.tests = toList(ts);
    
    for (Test t : this.tests) t.initialize();
  }
  
}
