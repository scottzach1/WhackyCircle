<T> ArrayList<T> toList(T[] arr) {
  ArrayList<T> l = new ArrayList();
  
  for (int i = 0; i < arr.length; ++i) l.add(arr[i]);
  
  return l;
}

boolean inBoundsIncl(int val, int lower, int upper) {
  return lower <= val && val <= upper;
}

boolean inBoundsExcl(int val, int lower, int upper) {
  return lower < val && val < upper;
}

<T> T listGet(ArrayList<T> l, int index, T fallback) {
  return inBoundsExcl(index, -1, l.size()) ? l.get(index) : fallback;
}

String getClassName(Object o, String fallback) {
  String s = o.getClass().getSimpleName();
  return (s.isEmpty()) ? fallback : s;
}
 
 int randomInt(int upper) {
   return int(random(upper));
 }

 int randomInt(int lower, int upper) {
   return int(random(lower, upper));
 }