/*--------------------------------------------------------------------------------------
 * Author:  Lihao Guo
 * 
 * Class: MinHeap
 *
 * Descripition: A MinHeap which holds the Event for the Points
 *
 *--------------------------------------------------------------------------------------*/
public class MinHeap { 

  private Point[] Heap; 
  private int pos; 

  public MinHeap(int n) 
  { 
    Heap = new Point[n];
    this.pos = 0;
  } 

  public Point getEvent(int i) {
    return i>= pos ? null:Heap[i];
  }

  public int getPos() {
    return pos;
  }
  //This function will return index Parent
  public int parent(int pos) 
  { 
    return ((pos - 1) / 2);
  } 

  //This function will return index of Left Child
  public int leftChild(int pos) 
  { 
    return ((2 * pos) + 1);
  } 

  // This function will returns index of Right Child
  public int rightChild(int pos) 
  { 
    return ((2 * pos) + 2);
  } 


  // Function to swap two nodes of the heap 
  private void swap(int i, int j) 
  { 
    Point tmp; 
    tmp = Heap[i]; 
    Heap[i] = Heap[j]; 
    Heap[j] = tmp;
  } 

  boolean add(Point x) {
    Heap[pos++] = x;
    bubbleUp(pos-1);
    return true;
  } 

  void bubbleUp(int i) {
    int p = parent(i);
    while (i > 0 && compare(Heap[i], Heap[p])) {
      swap(i, p);
      i = p;
      p = parent(i);
    }
  }

  boolean compare(Point x1, Point x2) {
    return x1.y <= x2.y;
  }

  public Point remove() {
    Point x = Heap[0];
    Heap[0] = Heap[--pos];
    trickleDown(0);
    if (pos < Heap.length) {
      Heap = Arrays.copyOf(Heap, Heap.length - 1);
    };
    return x;
  }


  void trickleDown(int i) {
    do {
      int j = -1;
      int r = rightChild(i);
      if (r < this.pos && compare(Heap[r], Heap[i])) {
        int l = leftChild(i);
        if (compare(Heap[l], Heap[r])) {
          j = l;
        } else {
          j = r;
        }
      } else {
        int l = leftChild(i);
        if (l < this.pos && compare(Heap[l], Heap[i])) {
          j = l;
        }
      }
      if (j >= 0)    swap(i, j);
      i = j;
    } while (i >= 0);
  }


  public void printHeap() 
  { 
    print("HEAP CONTAINS :");
    for (int i=0; i<pos; i++) 
      print(Heap[i].name + " ");
    println();
  }

  public void printRelation() 
  { 
    for (int i = 0; i < pos / 2 - 1; i++) { 
      System.out.print(">> PARENT : " + Heap[i].name
        + " LEFT CHILD : " + Heap[2 * i + 1].name 
        + " RIGHT CHILD :" + Heap[2 * i + 2].name); 
      System.out.println();
    }
  }
} 
