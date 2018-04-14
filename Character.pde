class Character {
  PShape icon;
  int posx, posy; // coordinates in the maze grid
  
  Character() {
    this.icon = loadShape("char_ladybug.svg"); // default icon
  }
  
  Character(String icon) {
    this.icon = loadShape("char_" + icon + ".svg");
  }
  
  void changeIcon(String newIcon) {
    PShape tmp = loadShape("char_" + newIcon + ".svg");
    if (tmp != null) {
      this.icon = tmp;
    }
  }
  
  void draw() {
    // Update position first
    if (keyPressed) {
      move();
    }
    
    // Draw icon
    pushMatrix();
    // TODO
    popMatrix();
  }
  
  void move() {
    int newx, newy;
    
    // Get new position attempt
    if (key == 65 || key == 97) { // Left (A or a)
      newx = this.posx - 1;
      
    } else if (key == 68 || key == 100) { // Right (D or d)
      newx = this.posx + 1;
      
    } else if (key == 87 || key == 119) { // Up (W or w)
      newy = this.posy - 1;
      
    } else if (key == 83 || key == 115) { // Down (S or s)
      newy = this.posy + 1;
      
    } else if (key == CODED) {
      if (keyCode == LEFT) { // Left arrow key
        newx = this.posx - 1;
        
      } else if (keyCode == RIGHT) { // Right arrow key
        newx = this.posx + 1;
        
      } else if (keyCode == UP) { // Up arrow key
        newy = this.posy - 1;
        
      } else if (keyCode == DOWN) { // Down arrow key
        newy = this.posy + 1;
        
      }
    }
    
    // Check if move is possible
    // TODO
  }
  
  boolean moveCheck(Maze maze, int newx, int newy) {
    // TODO
    // 1. Check if maze.tiles[newx][newy].solid == false
    // 2. Check that we're not crossing a wall
    return true;
  }
}
