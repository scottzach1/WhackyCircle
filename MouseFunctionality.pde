/**
* When the mouse is pressed, this method will fire. This is 
* different from the mousePressed boolean. This method will
* fire once when the mouse is pressed, and will not fire again
* unitl the mouse has been released. 
*/
void mousePressed() {
  try {
    game.getPhase().getTest().getShape().tryClick(mouseX, mouseY);
  } catch (NullPointerException e) {
    // There is no shape that the user could have clicked.
  };
}
