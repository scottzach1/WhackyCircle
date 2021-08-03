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

    if (t.completedShapes()) ++testIndex;
  }

  public boolean completedTests() {
    return testIndex >= tests.size();
  }

  public Test getTest() {
    return listGet(tests, testIndex, null);
  }

  public ArrayList<Test> getTests(){
    return new ArrayList(tests);
  }
  
  public void initialize() { // Implement for each phase
    println("WARN: " + getClassName(this, "Phase") + " Init Unimplemented");
  }
}

class Phase1 extends Phase {
  
  public void initialize() {
    Test[] ts = {new Test1()};
    
    this.tests = toList(ts);
    
    for (Test t : this.tests) t.initialize();
  }
  
}

class Phase2 extends Phase {
  
  public void initialize() {
    Test[] ts = {new Test2()};
    
    this.tests = toList(ts);
    
    for (Test t : this.tests) t.initialize();
  }
  
}

class Phase3 extends Phase {
  
  public void initialize() {
    Test[] ts = {new Test3()};
    
    this.tests = toList(ts);
    
    for (Test t : this.tests) t.initialize();
  }
  
}

class Phase4 extends Phase {
  
  public void initialize() {
    Test[] ts = {new Test4()};
    
    this.tests = toList(ts);
    
    for (Test t : this.tests) t.initialize();
  }
  
}
