enum ShapeType {
  CIRCLE, SQUARE
};

/**
 * Builder to generate single or multiple shapes with a given configuration.
 * Note that when `toList()` or `toSingle()` are called the builder will reset
 * its configuration. Please extend this with additional functionality where 
 * required.
 *
 * Example Usage:
 * 
 *      - ShapeBuilder().addType(ShapeType.SQUARE).setBounds(25, 75).toSingle();
 *      - ShapeBuilder().addTypes(ShapeType.values()).times(15).toList();
 */
class ShapeBuilder {
  private ArrayList<ShapeType> types = new ArrayList();
  private int lowerRadius = 50;
  private int upperRadius = 50; 
  private int times;
  
  ShapeBuilder() {}

  public ShapeBuilder clear() {
    types.clear();
    lowerRadius = 50;
    upperRadius = 50;
    times = 0;
    return this;
  }


  public ShapeBuilder addType(ShapeType st) {
    types.add(st);
    return this;
  }

  public ShapeBuilder addTypes(ShapeType[] st) {
    for (int i=0; i<st.length; ++i) types.add(st[i]);
    return this;
  }

  public ShapeBuilder times(int times) {
    this.times = times;
    return this;
  }

  public ShapeBuilder setBounds(int lowerRadius, int upperRadius) {
    this.lowerRadius = lowerRadius;
    this.upperRadius = upperRadius;
    return this;
  }

  public Shape toSingle() {
    Shape s = sampleOne();
    this.clear();
    return s;
  }

  public ArrayList<Shape> toList() {
    ArrayList<Shape> shapes = new ArrayList();
    for (int i=0; i<times; ++i) shapes.add(sampleOne());
    this.clear();
    return shapes;
  }


  private Shape sampleOne() {
    ShapeType st = types.get(randomInt(types.size()));
    return createRandom(st);
  }

  private Shape createRandom(ShapeType st) {
    int centreSize = Test.CENTRE_SIZE;
    int centreX = width / 2;
    int centreY = height / 2;

    int radius = randomInt(lowerRadius, upperRadius);
    int x, y; // temp invalid values.

    do  {
      x = randomInt(radius, width - radius);
      y = randomInt(radius, height - radius);
    } while (
      // None or either but not both are valid.
      (inBoundsExcl(x, centreX - centreSize - radius, centreX + centreSize + radius) && 
      inBoundsExcl(y, centreY - centreSize - radius, centreY + centreSize + radius)) || 
      game.getScore().outsideScoreBox(x, y, radius)
    );

    Shape s;
    switch (st) {
      case CIRCLE:
        s = new Circle(x, y, radius);
        break;
      case SQUARE:
        s = new Square(x, y, radius);
        break;
      default:
        s = new Square(x, y, radius);
        break;
    }
    return s;
  }
}

ShapeBuilder shapeBuilder = new ShapeBuilder();
