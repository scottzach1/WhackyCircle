class Circle {

    private Point p;
    private int r;


    public Circle(Point p, int r){
        this.p = p;
        this.r = r;
    }

    public void render(){
        ellipse(p.x, p.y, r*2, r*2);
    }
}