public static String negInf = "-oo";  // This is the -inf key value
public static String posInf = "+oo";  // This is the +inf key value

Console c = new Console(50, 416, 16);
SkipList T;

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
  Segments = new Segment[0];
}

void draw() {
  // Title 
  if (!c.readString().equals(""))
    surface.setTitle(c.readString() + ".in | Programming assignment #1.");

  // Console
  background(0);
  c.display();

  // Set the canvas
  stroke(255);
  fill(255);
  rect(0, 0, 800, 400);
  for (Segment seg : Segments) {
    seg.drawSegment(true);
  }

  if (SweepLine != -1) {
    stroke(255, 0, 255);
    line(Q[SweepLine].x, 0, Q[SweepLine].x, 400);
  }
}

void mousePressed() {
  println("Mouse Pressed");
}


void keyPressed()
{
  if (keyAnalyzer(key).compareTo("LETTER") == 0 || keyAnalyzer(key).compareTo("NUMBER") == 0) {
    c.addChar(key);
  } else if (keyCode == BACKSPACE) {
    c.deleteChar();
  } else if (keyCode == 10) { // Enter 
    if (GetSegments())
      GetAllPointsAndSort();
  } else if (keyCode == 112) { // F1
  } else if (keyCode == 113) { // F2
    SweepOnce();
  } else if (keyCode == 114) { // F3
    resetCanvas();
  } else {
    println(keyCode);
  }
}

void SweepOnce() {
  if (Q == null) {
    c.setTip("Not Start yet.");
  } else if (SweepLine < Q.length -1 ) {
    SweepLine++;
    Point p = Q[SweepLine];
    c.setTip("Meet the Points " + (SweepLine + 1) + " x:" + p.x + " y:" + p.y);
    TrigerEvents(p);
  } else
    c.setTip("End of the Points.");
}

void TrigerEvents(Point p) {
  //Events
  Node event = new Node(String.valueOf(p.name), p.line);

  if (p.isLeft()) {
    println("\n-------------Born Event : node  <" + String.valueOf(p.name)+">");
    // Check if this points intersects with its predecessor and successor
    // Insert s to status
    // find succ and pred and check Whether it is intersecting
    T.insert(event);
    T.printHorizontal();
    //Are_Intersecting(T.getNext(event), T.getPrev(event));
    c.setOutput("Born Event : node  <" + String.valueOf(p.name)+">\n" + T.VisualizeList());
  } else {  // If it's a right end of its line
    println("\n-------------Death Event : node  <" + String.valueOf(p.name)+">");
    //delete the segment from the skiplist
    // Check if its predecessor and successor intersect with each other
    T.delete(event);
    T.printHorizontal();
    c.setOutput("Death Event : node  <" + String.valueOf(p.name)+">\n" + T.VisualizeList());
    //Are_Intersecting(T.getNext(event), T.getPrev(event));
  }
}


boolean GetSegments() {
  if (c.readString().equals("")) {
    c.setTip("File name can not be Empty");
    return false;
  } 
  String filename = c.readString() + ".in";
  File f = new File(sketchPath(filename));
  boolean exist = f.isFile();
  //println(f.getPath(), exist);
  c.reset();
  SweepLine = -1;
  if (exist) {
    makeSegmentsAppear(filename);
    T = new SkipList();
    c.setTip("Successful Loaded");
    return true;
  } else {
    c.setTip("File is not exist.");
    return false;
  }
}

void resetCanvas() {
  Segments = new Segment[0];
  Q = new Point[0];
  SweepLine = -1;
  c.setTip("Cleaned.");
  c.setOutput("");
  surface.setTitle("Enter a new Segment File | Programming assignment #1.");
}
