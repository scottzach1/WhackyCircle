class Point {
  final int x, y;
  public Point(int x, int y) {
    this.x = x; 
    this.y = y;
  }
  
  @Override 
  public String toString(){
   return "[Point: x=" + x + ", y=" + y + "]"; 
  }

  float distanceFrom(Point p) {
    return dist(x, y, p.x, p.y);
  }
}
