class Character {
  // character icon
  PShape icon;
  
  // icon width & height
  float iconW, iconH;
  
  // coordinates in the maze grid
  int posx, posy;
  
  // direction the icon should face
  float rotate;
  
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
  
  void setIconColor(color newcolor) {
    this.icon.disableStyle();
    this.icon.setFill(newcolor);
  }
  
  void resetPos(Maze maze) {
    setCoords(maze, maze.startX, maze.startY);
    this.rotate = 0;
  }
  
  void setCoords(Maze maze, int newx, int newy) {
    // Check if position is possible
    if (isValidPos(maze, newx, newy)) {
      this.posx = newx;
      this.posy = newy;
    }
  }
  
  void draw(Maze maze) {
    // Update position first
    move(maze);
    
    // Get current position coordinates
    Vec2 coords = maze.tileCoords(this.posx, this.posy, "CENTER");
    
     //Set icon color
    fill(CP.line);
    stroke(CP.line);
    setIconColor(CP.line);
    
    pushMatrix();
    shapeMode(CENTER);
    
    // Rotate icon
    translate(coords.x, coords.y);
    rotate(this.rotate * (PI/2));
    
    // Draw icon
    shape(this.icon, 0, 0, this.iconW, this.iconH);
    
    shapeMode(CORNER);
    popMatrix();
  }
  
  void move(Maze maze) {
    int newx = this.posx;
    int newy = this.posy;
    
    if (app.wasKeyPressed('w')) {
      newy = this.posy - 1;
      this.rotate = 0;
    } else if (app.wasKeyPressed('a')) {
      newx = this.posx - 1;
      this.rotate = 3;
    } else if (app.wasKeyPressed('s')) {
      newy = this.posy + 1;
      this.rotate = 2;
    } else if (app.wasKeyPressed('d')) {
      newx = this.posx + 1;
      this.rotate = 1;
    }
    
    // If new position = current position, don't bother moving
    if (newx == this.posx && newy == this.posy) {
      return;
    }
    
    // Check if move is possible
    if (isValidMove(maze, newx, newy)) {
      this.posx = newx;
      this.posy = newy;
    }
  }
  
  boolean isValidPos(Maze maze, int newx, int newy) {
    // 1. Check if newx/newy is out of bounds
    if (!maze.isInBounds(newx, newy)) return false;
    
    // 2. Check if tile is wall or path
    if (!maze.isPath(newx, newy)) return false;
    
    // 3. If we pass the above tests, the move is valid
    return true;
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
