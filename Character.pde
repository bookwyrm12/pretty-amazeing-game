class Character {
  PShape icon;
  float iconW, iconH;
  int posx, posy; // coordinates in the maze grid
  
  Character() {
    this.icon = loadShape("char_ladybug.svg"); // default icon
    setIconSize(20, 14);
  }
  
  Character(String icon) {
    this.icon = loadShape("char_" + icon + ".svg");
    setIconSize(20, 14);
  }
  
  void changeIcon(String newIcon) {
    PShape tmp = loadShape("char_" + newIcon + ".svg");
    if (tmp != null) {
      this.icon = tmp;
    }
  }
  
  void setIconSize(float w, float h) {
    this.iconW = w;
    this.iconH = h;
  }
  
  void draw(Maze maze) {
    // Update position first
    if (keyPressed) {
      move(maze);
    }
    
    // Get current position coordinates
    float[] coords = maze.tileCoords(this.posx, this.posy);
    
    // Draw icon
    pushMatrix();
    shape(this.icon, coords[0], coords[1], this.iconW, this.iconH);
    popMatrix();
  }
  
  void move(Maze maze) {
    int newx = this.posx;
    int newy = this.posy;
    
    // Get new position attempt
    if (key == 'A' || key == 'a' || (key == CODED && keyCode == LEFT)) {
      newx = this.posx - 1;
      
    } else if (key == 'D' || key == 'd' || (key == CODED && keyCode == RIGHT)) {
      newx = this.posx + 1;
      
    } else if (key == 'W' || key == 'w' || (key == CODED && keyCode == UP)) {
      newy = this.posy - 1;
      
    } else if (key == 'S' || key == 's' || (key == CODED && keyCode == DOWN)) {
      newy = this.posy + 1;
      
    }
    
    // Check if move is possible
    if (isValidMove(maze, newx, newy)) {
      this.posx = newx;
      this.posy = newy;
    }
  }
  
  boolean isValidMove(Maze maze, int newx, int newy) {
    // 1. Check if newx/newy is out of bounds
    if (!maze.isInBounds(newx, newy)) return false;
    
    // 2. Check if tile is wall or path
    if (!maze.isPath(newx, newy)) return false;
    
    // 3. Check that we're not crossing a wall
    if (maze.isWallBetween(this.posx, this.posy, newx, newy)) return false;
    
    // 4. If we pass the above tests, the move is valid
    return true;
  }
}
