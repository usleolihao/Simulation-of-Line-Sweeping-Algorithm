/*--------------------------------------------------------------------------------------
 * Author: Lihao Guo 
 *
 * Class: Main
 *
 * Descripition: This Class is Main for holding the proccesing the GUI and hold the frame
 *                of the whole program to proccess the sweeping line algorithm.
 *
 *--------------------------------------------------------------------------------------*/

/********************************************************************
 *  Here are fields for I/O
 *******************************************************************/
// Arrays to hold our two sets of lines.
static Segment[] SEG;
// Arrays to hold our Points
static Point[] Q;
//The size of the Segment Lines
int SegmentsTotal;

/********************************************************************
 *  Here are fields for SkipList
 *  The status T must be stored as a SkipList.
 *******************************************************************/
public static String negInf = "-oo";  // This is the -inf key value
public static String posInf = "+oo";  // This is the +inf key value
SkipList T;

/********************************************************************
 *  Here are fields for MinHeap
 *******************************************************************/
MinHeap H;

/********************************************************************
 *  Here are fields for GUI
 *******************************************************************/
ArrayList<Point> Intersections = new ArrayList<Point>();
String filename = "";
boolean stop = true;
Console c = new Console(50, 416, 16);
Segment comp1 = null, comp2 = null, comp3 = null;
int SweepLine = -1;



void settings() { 
  // Set the window size
  size(1200, 470);
}

void setup() {
  // Set up Title 
  surface.setTitle("Cs345 | Programming assignment #1. Detecting Intersections between Segments");
  smooth();
  c.activate();
  SEG = new Segment[0];
}

void draw() {
  // Title 
  if (!c.readString().equals(""))
    surface.setTitle(c.readString() + ".in | Programming assignment #1.");

  // Console
  background(0);
  c.display();

  //thread for animation
  if (frameCount % 15 == 0 && stop == false) {
    SweepOnce();
  }

  // Set the canvas
  stroke(255);
  fill(255);
  rect(0, 0, 800, 400);
  for (Segment seg : SEG) {
    seg.drawSegment(true);
  }

  for (Point p : Intersections) {
    fill(255, 0, 0);
    noStroke();
    ellipse(p.x, p.y, 5, 5);
  }

  if (SweepLine != -1) {
    stroke(255, 0, 255);
    line(Q[SweepLine].x, 0, Q[SweepLine].x, 400);
  }
}



/********************************************************************
 *  This method will set up keyboard to perform working on the GUI
 *******************************************************************/
void keyPressed()
{
  if (keyAnalyzer(key).compareTo("LETTER") == 0 || keyAnalyzer(key).compareTo("NUMBER") == 0) {
    c.addChar(key);
  } else if (keyCode == BACKSPACE) {
    c.deleteChar();
  } else if (keyCode == 10) { // Enter 
    if (GetSegments())
      GetAllPointsAndSort();
    stop = true;
  } else if (keyCode == 112) { // F1
    if (stop) {
      stop = false;
    } else {
      stop = true;
    }
  } else if (keyCode == 113) { // F2
    SweepOnce();
    stop = true;
  } else if (keyCode == 114) { // F3
    resetCanvas();
    stop = true;
  } else {
    println(keyCode);
  }
}


/********************************************************************
 *  This method perform a Sweep line algorithm once
 *******************************************************************/
void SweepOnce() {
  UnHighlight();
  if (Q == null) {
    c.setTip("Not Start yet.");
    stop = true;
  } else if (SweepLine < Q.length -1 ) {
    SweepLine++;
    Point p = Q[SweepLine];
    c.setTip("Meet the Points " + (SweepLine + 1) + " x:" + p.x + " y:" + p.y);
    TrigerEvents(p);
  } else {
    c.setTip("End of the Points.");
    if (!stop && GetSegments()) {
      GetAllPointsAndSort();
    }
  }
}


/********************************************************************
 *  This method is for paiting the comparing GUI and draw 
 *  the poitn of Intersection
 *******************************************************************/
void PaintTwoLines(Segment s1, Segment s2) {
  println("Comparing " + s1.name + " , " + s2.name);
  c.setTip("Comparing " + s1.name + " , " + s2.name);
  s1.highlight();
  s2.highlight();
  if (Are_Intersecting(s1, s2)) {
    println( s1.name + " , " + s2.name + " are intersecting.");
    c.setTip( s1.name + " , " + s2.name + " are intersecting.");
    c.setRecord( s1.name + " , " + s2.name + " are intersecting.");
    DrawIntersectionPoint(s1, s2);
  } else
    c.setTip( s1.name + " , " + s2.name + " are not intersecting.");
}

/********************************************************************
 *  This method is getting the input file name read segments
 *******************************************************************/
boolean GetSegments() {
  if (c.readString().equals("") && filename.equals("")) {
    c.setTip("File name can not be Empty");
    return false;
  } 
  filename = !c.readString().equals("") ? c.readString() + ".in" : filename;
  File f = new File(sketchPath(filename));
  boolean exist = f.isFile();
  //println(f.getPath(), exist);
  c.reset();
  Intersections = new ArrayList<Point>();
  SweepLine = -1;
  if (exist) {
    makeSegmentsAppear(filename);
    T = new SkipList();
    H = new MinHeap(2 * SegmentsTotal);
    c.setTip("Successful Loaded");
    return true;
  } else {
    c.setTip("File is not exist.");
    return false;
  }
}

/********************************************************************
 *  This method will reset the Canvas
 *******************************************************************/
void resetCanvas() {
  SEG = new Segment[0];
  Q = new Point[0];
  Intersections = new ArrayList<Point>();
  SweepLine = -1;
  c.reset();
  c.setTip("Cleaned.");
  surface.setTitle("Enter a new Segment File | Programming assignment #1.");
}

/********************************************************************
 *  This method is unhighlight the line that we after sweep
 *******************************************************************/
void UnHighlight() {
  if (comp1 != null)
    comp1.unhighlight();
  if (comp2 != null)
    comp2.unhighlight();
  if (comp3 != null) 
    comp3.unhighlight();
}

/********************************************************************
 *  This method is calculating the point that intersect with two segment
 *  then give the point of Intersection
 *******************************************************************/
void DrawIntersectionPoint(Segment s1, Segment s2) {
  s1.Intersection();
  s2.Intersection();
  float x1 = s1.x1;
  float y1 = s1.y1;
  float x2 = s1.x2;
  float y2 = s1.y2;
  float x3 = s2.x1;
  float y3 = s2.y1;
  float x4 = s2.x2;
  float y4 = s2.y2;
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // optionally, draw a circle where the lines meet
    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));
    Intersections.add(new Point(intersectionX, intersectionY));
  }
}
