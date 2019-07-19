/*--------------------------------------------------------------------------------------
 * Author: Lihao Guo, Runnan Zhou
 *
 * Class: SkipList
 *
 * Descripition: This is the SkipList implementation that has the method to iterator the
 *               SkipList and fields
 *
 *--------------------------------------------------------------------------------------*/
import java.util.*;
class SkipList
{
  //---------------Node fields-------------
  public Node head;    // This is a First element of the top level
  public Node tail;    // This is a  Last element of the top level
  public Node current; //This is a current element of the SkipList

  //---------------Fields------------------
  public int height;   // Height    
  public int width;    // number of entries in the Skip List


  //---------------Constructor-------------
  public SkipList()     
  {
    //Create an -infinity and an +infinity object and Link
    Node node1 = new Node(negInf, null);
    Node node2 = new Node(posInf, null);
    node1.right = node2;
    node2.left  = node1;

    //Initialize head and tail
    head = node1;
    tail = node2;

    // Other
    width = 0;    // No entries in Skip List
    height = 0;   // Height is 0
  }


  //---------------Methods-----------------

  /********************************************************************
   *  This method will return the segment that next the point
   *******************************************************************/
  public Node getNext(Node x) {
    Node p = findEntry(x.key);
    while (p.down!=null) {
      p=p.down;
    } 
    return p.right;
  }

  public Node getNext(Point x) {
    Node p = findEntry(x);
    while (p.down!=null) {
      p=p.down;
    } 
    return p.right;
  }



  /********************************************************************
   *  This method will return the previous node
   *******************************************************************/
  public Node getPrev(Node x) {
    Node p = findEntry(x.key);
    while (p.down!=null) {
      p=p.down;
    }    
    return p.left;
  }

  public Node getPrev(Point x) {
    Node p = findEntry(x);
    while (p.down!=null) {
      p=p.down;
    }    
    return p.left;
  }

  /********************************************************************
   *  This method will reutrn size of the List
   *******************************************************************/
  public int size() { 
    return width;
  }


  /********************************************************************
   *  This method will return if List is empty
   *******************************************************************/
  public boolean isEmpty() { 
    return (width == 0);
  }

  /********************************************************************
   *  This method will perform the insert for skip list
   *******************************************************************/
  void insert(Node x, Point y)
  {
    Random r;
    int i;
    Node p;
    r= new Random();
    p=findEntry(y);

    x.left=p;
    x.right=p.right;
    p.right.left=x;
    p.right=x;
    i=0;

    while (r.nextDouble()<0.33)
    {
      {
        Node p1, p2;

        height = height + 1;

        p1 = new Node(negInf, null);
        p2 = new Node(posInf, null);

        p1.right = p2;
        p1.down  = head;

        p2.left = p1;
        p2.down = tail;

        head.up = p1;
        tail.up = p2;

        p1.setlevel(height);
        p2.setlevel(height);

        head = p1;
        tail = p2;
      }
      while ( p.up == null )
        p = p.left;

      p = p.up;
      Node e;

      e = new Node(x.key, x.value);

      //Initialize links of e
      e.left = p;
      e.right = p.right;
      e.down = x;
      e.setlevel(height);

      //Change the links..
      p.right.left = e;
      p.right = e;
      x.up = e;

      x = e;    // Set q up for the next iteration
      i = i + 1;  // Current level increased by 1
    }

    width=width+1;
  }

  /********************************************************************
   *  This method will perform the delete for skip list
   *******************************************************************/
  void delete(Node x)
  {
    Node p=findEntry(x.key);
    // node is not found
    if (!p.key.equals(x.key)) {
      System.out.println("The node is not found");
      return;
    }
    while (p.down != null) {
      p = p.down;
    }
    // link the left to right from level 0
    while (p !=null) {
      p.left.right = p.right;
      p.right.left = p.left;
      p = p.up;
    }
  }



  /********************************************************************
   *  This method will perform to find a Entry for skiplist
   *******************************************************************/
  public Node findEntry(String key)
  {
    Node ite;
    ite = head;
    while (ite.down!=null)
      ite=ite.down;

    while ( true ) {
      while ( !ite.right.key.equals(posInf) && !ite.key.equals(key))
        ite = ite.right;
      return ite;
    }
  }

  /********************************************************************
   *  This method will perform to find a Entry for skiplist
   *******************************************************************/
  public Node findEntry(Point p) {
    Node ite;
    ite=head;
    print("Head  >>> "+ ite.key);
    //print(ite.getNext());
    while (true) {
      if (ite.getNext()!=null) {
        while ((!ite.getNext().key.equals(posInf))) {
          if (Is_Above(ite.right.getValue(), p).equals("1")) {
            ite=ite.getNext();
            print(" >>> " + ite.key);
          } else if (p.line.y1>ite.getNext().getValue().y1) {
            println("Nope, we haven't reached the destination");
            ite=ite.getNext();
            print(" >>> " + ite.key);
          } else if (p.line==ite.getNext().getValue()) { 
            ite=ite.getNext();
            print(" >>> " + ite.key);
            //println("We have found the node");
            break;
          } else {
            //println("\nNext node is too big for me to continue");
            break;
          }
        }
        if (ite.down!=null)
        {
          ite=ite.down;
        } else {
          break;
        }
      }
    }
    println(" >>> " + tail.key);
    return ite;
  }



  /********************************************************************
   *  This method will perform a vlsualization for the Skip List
   *******************************************************************/
  public String VisualizeList() {
    String s = "";

    Node p = head;

    while ( p.down != null )
      p = p.down;

    int i = 0;
    while ( p != null )
    {
      p.pos = i++;
      p = p.right;
    }
    p = head;

    while ( p != null )
    {
      String temp = getOneRow( p );
      s += "level " + p.level + " | "  + temp + "\n";
      p = p.down;
    }
    return s;
  }

  /********************************************************************
   *  This method will perform to print for the skiplist
   *******************************************************************/
  public void printHorizontal()
  {
    println(VisualizeList());
  }


  /********************************************************************
   *  This method will perform to get one row element from the skiplist
   *******************************************************************/
  public String getOneRow( Node p )
  {
    String s;
    int a, b, i;
    a = 0;
    s = "" + p.key;
    p = p.right;
    while ( p != null )
    {
      Node q;
      q = p;
      while (q.down != null)
        q = q.down;
      b = q.pos;
      s = s + " <-";
      for (i = a+1; i < b; i++)
        s = s + "--------";
      s = s + "> " + p.key;
      a = b;
      p = p.right;
    }
    return(s);
  }
}
