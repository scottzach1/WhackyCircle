abstract class Shape {
  public boolean clicked;
  public final Point p;
  public final int r;

  public Shape(Point p, int r){
    this.p = p;
    this.r = r;
  }

  public abstract void render();
  public abstract void isClicked(Point mouse);
}


class Circle extends Shape {

  public Circle(Point p, int r) {
    super(p, r);
  }

  @Override
  public void render() {
    ellipse(p.x, p.y, r*2, r*2);
  }

  @Override
  public void isClicked(Point mouse){
    clicked = dist(mouse.x, mouse.y, p.x, p.y) < r;
  }
}

class Square extends Shape {

  public Square(Point p, int r) {
    super(p, r);
  }

  @Override
  public void render() {
    rectMode(RADIUS);
    rect(p.x, p.y, r, r);
  }

  @Override
  public void isClicked(Point mouse){
    clicked = mouse.x > p.x - r && mouse.x < p.x + r && mouse.y > p.y - r && mouse.y < p.y + r;
  }
}
