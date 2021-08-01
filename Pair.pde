class Pair<Left, Right> {

  public final Left left;
  public final Right right;

  public Pair(Left l, Right r) {
    this.left = l;
    this.right = r;
  }
  
  @Override
  public String toString(){
   return "Pair: left="+left+", right="+right; 
  }
}
