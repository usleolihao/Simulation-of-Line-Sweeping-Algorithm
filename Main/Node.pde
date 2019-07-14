class Node
{
  public String key;                 
  public Segment value;
  public int level;
  public int pos; 

  public Node up, down, left, right;           

  public Node(String key, Segment value) {
    this.key = key;
    this.value = value;
    this.level = 0;
    this.up = this.down = this.left = this.right =null;
  }

  public Segment getValue() {
    return this.value;
  }

  public String getKey() { 
    return this.key;
  }

  public void setlevel(int l) {
    level = l;
  }
  public Segment setValue(Segment val) 
  {
    Segment oldValue = value;
    value = val;
    return oldValue;
  }


  public boolean equals(Node node) {
    return (node.getKey().equals(key)) && (node.getValue().equals(value));
  }
}
