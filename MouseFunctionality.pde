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

void keyPressed() {
  if (keyCode == 8)
    game.handleKeyPress('-');
  else if(keyCode == 10)
    game.handleKeyPress('`');
  else if (Character.isAlphabetic(key) || Character.isDigit(key))
    game.handleKeyPress(key);
}
