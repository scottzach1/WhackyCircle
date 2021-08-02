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
  public abstract boolean within(Point point);

  public boolean within(int x, int y) {
    return within(new Point(x, y));
  }

  public boolean tryClick(Point point) {
    return (hasBeenClicked = within(point));
  }

  public boolean tryClick(int x, int y) {
    return tryClick(new Point(x, y));
  }

  public boolean hasBeenClicked() {
    return hasBeenClicked;
  }

  @Override
  public String toString() {
    return "[" + getClass().getSimpleName() + ": p=" + p.toString() + ", r=" + r + "]";
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
  public boolean within(Point point) {
    return p.distanceFrom(point) < r;
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
  public boolean within(Point point) {
    return true &&
      inBoundsIncl(point.x, p.x - r, p.x + r) &&
      inBoundsIncl(point.y, p.y - r, p.y + r);
  }
}


class Image extends Shape {
  private PImage img;
  
  public Image(PImage i, Point p, int r) {
    super(p, r);
    img = i;
  }

  public Image(PImage i, int x, int y, int r) {
    super(x, y, r);
    img = i;
  }
  
  @Override
  public void render() {
    imageMode(CENTER);
    if (img != null)
      image(img, p.x, p.y, r * 2, r * 2);
  }
  
  @Override
  public boolean within(Point point) {
    return true &&
      inBoundsIncl(point.x, p.x - r, p.x + r) &&
      inBoundsIncl(point.y, p.y - r, p.y + r);
  }
  
}
