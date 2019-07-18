/********************************************************************
 *  This method will perform the Event when sweeping the lines
 *******************************************************************/
void TrigerEvents(Point p) {
  //Events
  String k = String.valueOf(p.name);
  Node event = new Node(k, p.line);
  if (p.isLeft()) { 
    println("\n-------------Born Event : node  <" + k +">");
    //Queue Event into MinHeap;
    H.add(p);
    H.printHeap();
    H.printRelation();
    // Insert s to status
    T.insert(event, p);
    T.printHorizontal();
    // find succ and pred and check Whether it is intersecting
    Segment SUCC = succ(p, T);
    Segment PRED =  pred(p, T);
    if (SUCC != null) {
      PaintTwoLines(SUCC, p.line);
      comp1 = SUCC;
      comp3 = p.line;
      delay(100);
    }

    if (PRED != null) {
      PaintTwoLines(PRED, p.line);
      comp1 = PRED;
      comp3 = p.line;
      delay(100);
    }
    c.setOutput("Born Event : node  <" + k +">\n" + T.VisualizeList());
  } else {  // If it's a right end of its line
    println("\n-------------Death Event : node  <" + k +">");
    //Pop out Event from MinHeap;
    println("Heap Remove - " + H.remove().name);
    //delete the segment from the skiplist
    // Check if its predecessor and successor intersect with each other
    Segment next = T.getNext(event);
    Segment prev =  T.getPrev(event);
    if (next != null && prev != null) {
      PaintTwoLines(next, prev);
      comp1 = next;
      comp2 = prev;
    }
    T.delete(event);
    T.printHorizontal();
    c.setOutput("Death Event : node  <" + k +">\n" + T.VisualizeList());
  }
}


Segment succ (Point p, SkipList T) { 
  Point succ = H.getEvent(H.rightChild(H.getPos()/4));
  if (p.equals(succ) || succ == null)
    return null;
  Segment s= T.findEntry(succ.name).value;
  println("Succ : " + succ.name + " " + s.name);
  return s;
}

Segment pred (Point p, SkipList T) {
  Point pred = H.getEvent(H.leftChild(H.getPos()/4));
  if (p.equals(pred) || pred ==null)
    return null;
  Segment s = T.findEntry(pred.name).value;
  println("Pred : " + pred.name+ " " + s.name);
  return s;
}

/********************************************************************
 *  This method will get all points from the segment and sort them
 *   And print the Points sorted before and after
 *******************************************************************/
void GetAllPointsAndSort() {
  int n = Q.length;
  for (int i = 0; i < n/2; i++)
    Q[i] = SEG[i].getP1();
  for (int i = 0, j = n/2; j < Q.length; i++, j++) 
    Q[j] = SEG[i].getP2();

  println("\nThe Events before sort"); 
  printAllPoints(Q);
  QuickSort ob = new QuickSort();
  ob.sort(Q, 0, n-1);
  println("sorted Events"); 
  printAllPoints(Q);
  c.setTip("Points has been sorted");

  for (Point p : Q) {
    H.add(p);
    H.printHeap();
  }
  H.printRelation();
  for (Point p : Q) {
    println("remove " + H.remove().name);
    H.printHeap();
  }
  
  
}

/********************************************************************
 *  This method will print All Points from the Array
 *******************************************************************/
void printAllPoints(Point[] arr) { 
  int n = arr.length; 
  for (int i=0; i<n; ++i) 
    println((arr[i].Line()!= null ? "L:" + arr[i].Line().name + " | "  : "none") + arr[i].x + "," +arr[i].y + " " ); 
  println();
} 
