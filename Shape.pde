abstract class Shape {
  public boolean clicked;
  public final Point p;
  public final int r;
  
  public Shape(Point p, int r) {
    this.p = p;
    this.r = r;
  }

  public Shape(int x, int y, int r) {
    this(new Point(x, y), r);
  }
  
  public abstract void render();
  public abstract void isClicked(Point mouse);
  public abstract boolean isHovering(Point mouse);
  
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
  public void isClicked(Point mouse) {
    clicked = dist(mouse.x, mouse.y, p.x, p.y) < r;
  }
  
  @Override
  public boolean isHovering(Point mouse) {
    return dist(mouse.x, mouse.y, p.x, p.y) < r;
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
  public void isClicked(Point mouse) {
    clicked = mouse.x > p.x - r && mouse.x < p.x + r && mouse.y > p.y - r && mouse.y < p.y + r;
  }
  
  @Override
  public boolean isHovering(Point mouse) {
    return mouse.x > p.x - r && mouse.x < p.x + r && mouse.y > p.y - r && mouse.y < p.y + r;
  }
}
