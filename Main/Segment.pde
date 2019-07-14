/*--------------------------------------------------------------------------------------
 * Author: Jacob Rafko
 *
 * Class: Segment
 *
 * Descripition: Object used for lines, stores points and can be used to compare
 *
 *--------------------------------------------------------------------------------------*/
class Point {
  public float x, y;
  private boolean left;
  public String name;
  private Segment line;

  Point(float x, float y, boolean left, String name, Segment line) {
    this.x = x;
    this.y = y;
    this.left = left;
    this.line = line;
    this.name = name;
  }

  boolean isLeft() {
    return left;
  }

  Segment Line() {
    return line;
  }
}

class Segment {
  private float x1, x2, y1, y2;
  private color lineColor;
  public String name;
  private Point p1, p2;

  // Initialize a line with no pre-set color
  Segment(String name, float x1Cord, float x2Cord, float y1Cord, float y2Cord) {
    x1 = x1Cord;
    x2 = x2Cord;
    y1 = y1Cord;
    y2 = y2Cord;
    this.name = name;
    String Key = isLeft(x1, x2)? "" + y1: "" + y2;
    p1 = new Point(x1, y1, isLeft(x1, x2), Key, this);
    p2 = new Point(x2, y2, isLeft(x2, x1), Key, this);
    // Set the color to the starting color
    lineColor = color(182, 125, 67);
  }

  // Initialize a line with a specific color
  Segment(String name, float x1Cord, float x2Cord, float y1Cord, float y2Cord, color newSegmentsColor) {
    x1 = x1Cord;
    x2 = x2Cord;
    y1 = y1Cord;
    y2 = y2Cord;
    String Key = isLeft(x1, x2)? "" + y1: "" + y2;
    p1 = new Point(x1, y1, isLeft(x1, x2), Key, this);
    p2 = new Point(x2, y2, isLeft(x2, x1), Key, this);
    lineColor = newSegmentsColor;
    this.name = name;
  }

  public boolean isLeft(float x1, float x2) {
    return x1<=x2;
  }
  // Getters
  public float getX1() { 
    return x1;
  }
  public float getX2() { 
    return x2;
  }
  public float getY1() { 
    return y1;
  }
  public float getY2() { 
    return y2;
  }
  public Point getP1() { 
    return p1;
  }
  public Point getP2() { 
    return p2;
  }

  // Setters
  public void setX1(float newValue) { 
    x1 = newValue;
  }
  public void setX2(float newValue) { 
    x2 = newValue;
  }
  public void setY1(float newValue) { 
    y1 = newValue;
  }
  public void setY2(float newValue) { 
    y2 = newValue;
  }
  public void highlight() { 
    lineColor = color(64, 20, 60);
  }
  public void unhighlight() { 
    lineColor = color(182, 125, 67);
  }

  // Draw method
  void drawSegment(boolean showEndPoints) {
    // Set the color
    stroke(lineColor);
    // Set the thickness of the line.
    strokeWeight(3);
    // Draw the Segment
    line(x1, y1, x2, y2);

    // Draw the Name of line
    fill(0);
    text(name, x1 + 5, y1 - 5);

    fill(255);
    // If we should show the end points, draw them.
    if (showEndPoints) {
      ellipse(x1, y1, 10, 10);
      ellipse(x2, y2, 10, 10);
    }
  }
}
