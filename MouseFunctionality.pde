/**
 * When the mouse is pressed, this method will fire. This is 
 * different from the mousePressed boolean. This method will
 * fire once when the mouse is pressed, and will not fire again
 * unitl the mouse has been released. 
 */
Long z;
boolean flick = false;
void mousePressed() {
  // Testing PathTracker
  if (!flick) {
    z = System.currentTimeMillis();
    pt.start();
    flick = true;
  } else {
    ArrayList<Pair<Long, Point>> a = pt.stop();
    stroke(255, 0, 0);
    strokeWeight(10);
    for (int i = 1; i < a.size(); i++) {
      Point p1 = a.get(i-1).right;
      Point p2 = a.get(i).right;
      line(p1.x, p1.y, p2.x, p2.y);
    }
    flick = false;
  }
}
