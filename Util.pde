<T> ArrayList<T> toList(T[] arr) {
  ArrayList<T> l = new ArrayList();
  
  for (int i = 0; i < arr.length; ++i) l.add(arr[i]);
  
  return l;
}

boolean inBounds(int val, int lower, int upper) {
  return lower <= val && val <= upper;
}