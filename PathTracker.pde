class PathTracker {
  private boolean running;
  private Thread t;
  private ArrayList<Pair<Long, Point>> path;
  
  public void start() {
    if (running) return;
    running = true;
    path = new ArrayList();
    t = new Runner();
    t.start();
  }
  
  public ArrayList<Pair<Long, Point>> stop() {
    if (!running) return new ArrayList();
    t.interrupt();
    running = false;
    return new ArrayList(path);
  }
  
  
  class Runner extends Thread {
    public boolean running = false;
    private final int READS_PER_SEC = 60;
    
    public void run() {
      long time = millis();
      while(true) {
        if (this.isInterrupted()) {
          break;
        }
        Long diff = millis() - time;
        if ((diff > 0) && (READS_PER_SEC <= 0 || diff % (1000 / READS_PER_SEC) == 0)) {
          time = millis();
          path.add(new Pair(time, new Point(mouseX, mouseY)));
        }
      }
    }
  }
}
