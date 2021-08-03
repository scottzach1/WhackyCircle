/**
* When the mouse is pressed, this method will fire. This is 
* different from the mousePressed boolean. This method will
* fire once when the mouse is pressed, and will not fire again
* unitl the mouse has been released. 
*/
void mousePressed() {
  game.handleMouseClick(mouseX, mouseY);
}

void mouseWheel(MouseEvent e){
  game.handleMouseWheel(e.getCount());
}
