/*--------------------------------------------------------------------------------------
 * Function provided by Jacob Rafko from Start_Function
 *         
 *
 * Class: Utility
 *
 * Descripition: this class includes function to read a file, output information, 
 *               Comparison of the segments etc...
 *
 *--------------------------------------------------------------------------------------*/

//For the Intersections
import java.awt.geom.Line2D;


// Arrays to hold our two sets of lines.
static Segment[] Segments;
// Arrays to hold our Points
static Point[] Q;

//The size of the Segment Lines
int SegmentsTotal;

//This will plot all the lines from the file name passed into it
void makeSegmentsAppear(String fileName) {

  // Read in the lines from the horizontal and vertical line files.
  String fileSegment = null;
  BufferedReader reader;
  float x1, y1, x2, y2;
  int size, i = 0;

  try {
    //Make this open a file from input line
    reader = createReader(fileName);

    // Create horizontal lines array.
    fileSegment = reader.readLine();
    size = Integer.parseInt(fileSegment);
    SegmentsTotal = size;
    Segments = new Segment[size];
    Q = new Point[size*2];

    //Input: x1,y1,x2,y2
    println("Information of the Segments");
    while ( (fileSegment = reader.readLine()) != null) {
      String[] fields = fileSegment.split(",");
      x1 = Float.parseFloat(fields[0]);
      y1 = Float.parseFloat(fields[1]);
      x2 = Float.parseFloat(fields[2]);
      y2 = Float.parseFloat(fields[3]);

      // i plus 1 is their name
      // so this name would be "h\(i + 1)"
      String theName = "" + (i + 1);

      // Add new horizontal line
      Segments[i] = new Segment(theName, x1, y1, x2, y2);

      println(theName + " - x1:" + x1  + " y1:"+ y1 + " x2:" + x2+" y2:"+y2);
      i++;
    }

    reader.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
}

/********************************************************************
 *  This method will take in two lines and determine if they
 *  intersect each other at any point
 * @param l1: The first segment
 * @param l2: The second segment
 *******************************************************************/
public boolean Are_Intersecting(Segment l1, Segment l2) {
  String[] coordsStrs = {String.valueOf(l1.x1), String.valueOf(l1.y1), 
    String.valueOf(l1.x2), String.valueOf(l1.y2), String.valueOf(l2.x1), String.valueOf(l2.y1), 
    String.valueOf(l2.x2), String.valueOf(l2.y2)};
  Double[] cDs = new Double[8];
  for (int i = 0; i < 8; i++) cDs[i] = Double.parseDouble(coordsStrs[i]);
  return Line2D.linesIntersect(cDs[0], cDs[1], cDs[2], cDs[3], cDs[4], cDs[5], cDs[6], cDs[7]);
}

/********************************************************************
 * This method will return a String based on the parameters passed in
 * if point is above the segment: "1:" + distance 
 * if below: "-1:" + distance
 * if on the line: "0"
 * else(left or right of line/not on graph): "ERROR"
 * @param line: The line that will be indexed
 * @param p: The point to compare with
 *******************************************************************/
public String Is_Above(Segment line, Point p) {
  if (p.x < line.x1) return "ERROR";
  if (p.x > line.x2) return "ERROR";
  double slope = (line.y2 - line.y1) / (line.x2 - line.x1);
  double newY = slope * (p.x - line.x1); 
  newY += line.y1;
  if (p.y > newY) return "1:" + (int)(p.y-newY);
  if (p.y < newY) return "2:" + (int)(newY-p.y);
  if (p.y - newY < .05 || p.y - newY > -.05) return "0";
  return "ERROR";
}
