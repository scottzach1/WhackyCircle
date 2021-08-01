/**
* When the mouse is pressed, this method will fire. This is 
* different from the mousePressed boolean. This method will
* fire once when the mouse is pressed, and will not fire again
* unitl the mouse has been released. 
*/
void mousePressed() {
  try {
    game.curPhase.curTest.curShape.isClicked(new Point(mouseX, mouseY));
  } catch (NullPointerException e) {println(e);};
}
