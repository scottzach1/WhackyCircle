class Square {

  public final Point p;
  public final int r;


  public Square(Point p, int r) {
    this.p = p;
    this.r = r;
  }

  public void render() {
    rect(p.x, p.y, r*2, r*2);
  }
}
