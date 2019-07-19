/*--------------------------------------------------------------------------------------
 * Author: Lihao Guo  Runnan Zhou
 *
 * Class: Node
 *
 * Descripition: This Object is the Node of the SkipList
 *
 *--------------------------------------------------------------------------------------*/
class Node
{
  //Fields
  public String key;                 
  private Segment value;
  public int level;
  public int pos; 

  public Node up, down, left, right;           

  //Construction
  public Node(String key, Segment value) {
    this.key = key;
    this.value = value;
    this.level = 0;
    this.up = this.down = this.left = this.right =null;
  }

  //get Value of the node
  public Segment getValue() {
    return this.value;
  }
  public Node getNext(){
  return this.right;
  }
  public Node getPrev(){
  return this.left;
  }
  //get Key of the node
  public String getKey() { 
    return this.key;
  }

  //Set level for skiplist
  public void setlevel(int l) {
    level = l;
  }
  
  //customize equals for node
  public boolean equals(Node node) {
    return (node.getKey().equals(key)) && (node.getValue().equals(value));
  }
  
}
