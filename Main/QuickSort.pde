/*--------------------------------------------------------------------------------------
 * Author: Lihao Guo  Runnan Zhou
 *
 * Class: QuickSort
 *
 * Descripition: This Object is used for sorting Points by QuickSort
 *
 *--------------------------------------------------------------------------------------*/
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
        swap( arr, i, j);
      }
    } 
    swap( arr, i+1, high);
    return i+1;
  } 


  void swap(Point[] arr, int i, int j) {
    // swap arr[i+1] and arr[high] (or pivot) 
    Point temp = arr[i]; 
    arr[i] = arr[j]; 
    arr[j] = temp;
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
