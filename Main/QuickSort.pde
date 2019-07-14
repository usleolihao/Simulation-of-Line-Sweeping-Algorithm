void GetAllPointsAndSort() {
  int n = Q.length;
  for (int i = 0; i < n/2; i++)
    Q[i] = Segments[i].getP1();
  for (int i = 0, j = n/2; j < Q.length; i++, j++)
    Q[j] = Segments[i].getP2();

  println("The Points before sort"); 
  printAllPoints(Q);
  QuickSort ob = new QuickSort();
  ob.sort(Q, 0, n-1);
  println("sorted Points"); 
  printAllPoints(Q);
  c.setTip("Points has been sorted");
}

void printAllPoints(Point[] arr) { 
  int n = arr.length; 
  for (int i=0; i<n; ++i) 
    print(arr[i].x + " " + (arr[i].Line()!= null ? "L:" + arr[i].Line().name + " " : "none") ); 
  println();
} 

class QuickSort 
{ 
  int partition(Point arr[], int low, int high) 
  { 
    float pivot = arr[high].x;  
    int i = (low-1);
    for (int j=low; j<high; j++) 
    { 
      // If current element is smaller than or  equal to pivot 
      if (arr[j].x <= pivot) { 
        i++; 
        // swap arr[i] and arr[j] 
        Point temp = arr[i]; 
        arr[i] = arr[j]; 
        arr[j] = temp;
      }
    } 
    // swap arr[i+1] and arr[high] (or pivot) 
    Point temp = arr[i+1]; 
    arr[i+1] = arr[high]; 
    arr[high] = temp; 
    return i+1;
  } 


  void sort(Point arr[], int low, int high) 
  { 
    if (low < high) { 
      int pi = partition(arr, low, high); 
      sort(arr, low, pi-1); 
      sort(arr, pi+1, high);
    }
  }
} 
