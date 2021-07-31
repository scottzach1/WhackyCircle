abstract class TestAttr {
  public void execute() {
    println("Unimplemented Attr");
  }
}

class Phase2TestAttr extends TestAttr {
  public void execute() {
    stroke(random(0, 255), random(0, 255), random(0, 255))
  }
}