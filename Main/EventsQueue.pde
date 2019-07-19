/********************************************************************
 *  This method will perform the Event when sweeping the lines
 *******************************************************************/
void TrigerEvents(Point p) {
  //Events
  String k = String.valueOf(p.name);
  Node event = new Node(k, p.line);

  // Queue Event
  H.add(p);
  H.printHeap();
  //H.printRelation();

  if (p.isLeft()) { 
    println("-------------Born Event : node  <" + k +">-----------------");
    // Insert s to status
    T.insert(event, p);
    T.printHorizontal();
    while(event.down != null)
      event = event.down;
    Node Prev = event.left;
    Segment SUCC = Prev.value == null? null : Prev.value;
    Node Next = event.right;
    Segment PRED = Next.value == null? null : Next.value;
    // find succ and pred and check Whether it is intersecting
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
    println("-------------Death Event : node  <" + k +">-----------------");
    T.printHorizontal();
    H.printHeap();

    Segment SUCC = succ(p, event);
    Segment PRED = pred(p, event);

    // Check if its predecessor and successor intersect with each other
    if (SUCC != null && PRED != null) {
      PaintTwoLines(SUCC, PRED);
      comp1 = SUCC;
      comp2 = PRED;
    }
    //delete the segment from the skiplist
    T.delete(event);
    T.printHorizontal();
    c.setOutput("Death Event : node  <" + k +">\n" + T.VisualizeList());
  }
}

//find the Segment just Below which must be the Prev One
Segment pred(Point p, Node event) {
  double dis = 999999;
  println("find PrevNode: ");
  Node ite = T.getNext(event);
  Segment s = ite.value == null ? null : ite.value;
  if ( s != null) {
    dis = Is_Above2(s, p);
    println(ite.key + " dis: " + dis );
  }
  while (!(ite.value == null) && !ite.right.key.equals(posInf) && Is_Above(ite.right.value,p).equals("1")) {
    ite = ite.right;
    double dis2 = Is_Above2(ite.value, p);
    print(" >>> " + ite.key + " dis: " + dis2);
    if (dis2 < dis && dis2 != 0) {
      dis = dis2;
      s = ite.value;
    }
  }
  println("\nPred : " + (s==null ? null: s.name));
  return s;
}

Segment succ(Point p, Node event) {
    double dis = 999999;
  println("find PrevNode: ");
  Node ite = T.getPrev(event);
  Segment s = ite.value;
  if ( s != null) {
    dis = Is_Above2(s, p);
    println(ite.key + " dis: " + dis );
  }
  while (!(ite.value == null) && !ite.left.key.equals(negInf) && Is_Above(ite.left.value,p).equals("-1")) {
    ite = ite.left;
    double dis2 = Is_Above2(ite.value, p);
    print(" >>> " + ite.key + " dis: " + dis2);
    if (dis2 < dis && dis2 != 0) {
      dis = dis2;
      s = ite.value;
    }
  }
  println("\nSucc : " + (s==null ? null: s.name));
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

  /*
  for (Point p : Q) {
   println("------------add------------------");
   H.add(p);
   H.printHeap();
   }
   H.printRelation();
   for (Point p : Q) {
   println("remove " + H.remove().name);
   H.printHeap();
   }
   */
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
