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
    Node node1, node2;

    //Create an -infinity and an +infinity object
    node1 = new Node(negInf, null);
    node2 = new Node(posInf, null);

    //Link the -infinity and +infinity object together
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

  //will return the next node
  public Segment getNext(Node x) {
    print("find next : ");
    Node p = findEntry(x.key);
    while (p.down!=null) {
      p=p.down;
    } 
    println(" | get Next " + p.right.key);
    return p.right.value;
  }


  //will return the previous node
  public Segment getPrev(Node x) {
    print("find prev : ");
    Node p = findEntry(x.key);
    print("This is the p which we have found");
    print(p.right.key);
    while (p.down!=null) {
      p=p.down;
    }    
    
    println(" | get Prev " + p.left.key);
    return p.left.value;
  }

  // reutrn size of the List
  public int size() { 
    return width;
  }

  // return if List is empty
  public boolean isEmpty() { 
    return (width == 0);
  }

  void insert(Node x, Point y)
  {
    Random r;
    int i;
    Node p;
    r= new Random();
    p=findEntry(y);
    //if the key is already exist,then revise it
    if (x.key.equals(p.key)) {
      p.value = x.value;
      return;
    }

    
    x.left=p;
    x.right=p.right;
    p.right.left=x;
    p.right=x;
    i=0;

    while (r.nextDouble()<0.5)
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
      {
        //     System.out.print(".");
        p = p.left;
      }

      //  System.out.print("1 ");

      p = p.up;
      Node e;

      e = new Node(x.key, x.value);  // Don't need the value...

      /* ---------------------------------------
       Initialize links of e
       --------------------------------------- */
      e.left = p;
      e.right = p.right;
      e.down = x;
      e.setlevel(height);

      /* ---------------------------------------
       Change the neighboring links..
       --------------------------------------- */
      p.right.left = e;
      p.right = e;
      x.up = e;


      x = e;    // Set q up for the next iteration

      i = i + 1;  // Current level increased by 1
    }

    width=width+1;
  }

  void delete(Node x, Point y)
  {
    Node p=findEntry(x.key);
    // node is not found
    print("This is the key return by function");
    print(p.key);
    print("This is the key input");
    print(x.key);
    if (!p.key.equals(x.key)) {
      System.out.println("The node is not found");
      return;
    }
    while (p.down != null)
      p = p.down;
    // link the left to right from level 0
    while (p !=null) {
      p.left.right = p.right;
      p.right.left = p.left;
      p = p.up;
    }
  }


  //public Node findEntry(String key)
  //{
  //  Node ite;
  //  ite = head;
  //  print("Head:" + ite.key + " ");
  //  while ( true ) {
  //    while ( !ite.right.key.equals(posInf) && !ite.key.equals(key))
  //    {
  //      print(">>>> " + ite.right.key + " ");
  //      ite = ite.right;
  //    }

  //    if (ite.value != null && ite.down != null )
  //    {  
  //      println();
  //      ite = ite.down;
  //      //println("vvvv " + p.key);
  //    } else {
  //      print(">>>> " + ite.right.key + " ");
  //      break;
  //    }
  //  }
  //  // p.key <= key 
  //  print("| to find " + key  + " found: " + ite.key);
  //  return ite;
  //}
  public Node findEntry(String key)
  {
    Node ite;
    ite = head;
    print("Head:" + ite.key + " ");
    while (ite.down!=null)
    {
      ite=ite.down;
    }
    while ( true ) {
      while ( !ite.right.key.equals(posInf) && !ite.key.equals(key))
      {
        print(">>>> " + ite.right.key + " ");
        ite = ite.right;
      }

      
    
    // p.key <= key 
    
    return ite;
  }
  }

  public Node findEntry(Point p)
  {
    Node ite;
    ite = head;
    print("Head:" + ite.key + " ");
    while ( true ) {
      while ( !ite.right.key.equals(posInf))
      {
        print(">>>> " + ite.right.key + " ");

        if (Is_Above(ite.right.getValue(), p).equals("1")) {
          print(">>>> " + ite.right.key + " ");
          print("1");
          break;
        } else
          ite = ite.right;
      }

      if (ite.down != null )
      {  
        println();
        ite = ite.down;
        //println("vvvv " + p.key);
      } else {
        print(">>>> " + ite.right.key + " ");
        break;
      }
    }
    // p.key <= key 
    println("| Node: " + ite.key);
    return ite;
  }


  public String VisualizeList() {
    String s = "";
    int i;

    Node p;

    /* ----------------------------------
     Record the position of each entry
     ---------------------------------- */
    p = head;

    while ( p.down != null )
    {
      p = p.down;
    }

    i = 0;
    while ( p != null )
    {
      p.pos = i++;
      p = p.right;
    }

    /* -------------------
     Print...
     ------------------- */
    p = head;

    while ( p != null )
    {
      String temp = getOneRow( p );
      s += "level " + p.level + " | "  + temp + "\n";
      p = p.down;
    }

    return s;
  }

  public void printHorizontal()
  {
    println(VisualizeList());
  }

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
