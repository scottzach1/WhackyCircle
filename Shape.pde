abstract class Shape {
  public final Point p;
  public final int r;

  protected boolean hasBeenClicked = false;
  
  public Shape(Point p, int r) {
    this.p = p;
    this.r = r;
  }

  public Shape(int x, int y, int r) {
    this(new Point(x, y), r);
  }
  
  public abstract void render();
  public abstract boolean within(Point mouse);

  public boolean within(int x, int y) {
    return within(new Point(x, y));
  }

  public boolean tryClick(Point mouse) {
    return (hasBeenClicked = within(mouse));
  }

  public boolean tryClick(int x, int y) {
    return tryClick(new Point(x, y));
  }

  public boolean hasBeenClicked() {
    return hasBeenClicked;
  }
}

class Circle extends Shape {
  
  public Circle(Point p, int r) {
    super(p, r);
  }

  public Circle(int x, int y, int r) {
    super(x, y, r);
  }
  
  @Override
  public void render() {
    ellipse(p.x, p.y, r * 2, r * 2);
  }
  
  @Override
  public boolean within(Point mouse) {
    return p.distanceFrom(mouse) < r;
  }
}

class Square extends Shape {
  
  public Square(Point p, int r) {
    super(p, r);
  }

  public Square(int x, int y, int r) {
    super(x, y, r);
  }
  
  @Override
  public void render() {
    rectMode(RADIUS);
    square(p.x, p.y, r);
  }
  
  @Override
  public boolean within(Point mouse) {
    return true &&
      inBoundsExcl(mouse.x, p.x - r, p.x + r) &&
      inBoundsExcl(mouse.y, p.y - r, p.x + r);
  }
}
