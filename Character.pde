class Character {
  // character icon
  PShape icon;
  
  // icon width & height
  float iconW, iconH;
  
  // coordinates in the maze grid
  int posx, posy;
  
  // direction the icon should face
  float rotate;
  
  // keep track of move trail
  ArrayDeque<int[]> moveTrail;
  
  Character() {
    this.icon = loadShape("char_ladybug.svg"); // default icon
    setIconSize(20, 14);
    moveTrail = new ArrayDeque<int[]>();
  }
  
  Character(String icon) {
    this.icon = loadShape("char_" + icon + ".svg");
    setIconSize(20, 14);
    moveTrail = new ArrayDeque<int[]>();
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
    this.moveTrail.clear();
  }
  
  void setCoords(Maze maze, int newx, int newy) {
    // Check if position is possible
    if (isValidPos(maze, newx, newy)) {
      this.posx = newx;
      this.posy = newy;
      this.moveTrail.clear();
    }
  }
  
  void draw(Maze maze, float scaleFactor) {
    // Update position first
    move(maze);
    
    // Get current position coordinates
    Vec2 coords = maze.tileCoords(this.posx, this.posy, "CENTER", scaleFactor);
    
    pushMatrix();
    shapeMode(CENTER);
    
    // Color current tile & trail tiles
    drawTrail(maze);
    
    // Set icon color
    fill(CP.line);
    stroke(CP.line);
    setIconColor(CP.line);
    
    // Transform the icon
    translate(coords.x, coords.y);
    rotate(this.rotate * (PI/2));
    scale(scaleFactor);
    
    // Draw icon
    shape(this.icon, 0, 0, this.iconW, this.iconH);
    
    shapeMode(CORNER);
    popMatrix();
  }
  
  void drawTrail(Maze maze) {
    // Set fade/alpha var
    int fade = 255;
    
    // Color current tile
    maze.colorTile(this.posx, this.posy, CP.border, fade, "ELLIPSE");
    
    // Color trail tiles
    Iterator<int[]> trail = this.moveTrail.descendingIterator();
    while (trail.hasNext()) {
      if (fade > 0) {
        fade -= (255 * 0.2);
      }
      int[] t = trail.next();
      maze.colorTile(t[0], t[1], CP.border, fade, "ELLIPSE");
    }
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
      // Add position to trail
      this.moveTrail.add( new int[] { this.posx, this.posy } );
      if (this.moveTrail.size() > 5) {
        this.moveTrail.remove();
      }
      
      // Move
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
