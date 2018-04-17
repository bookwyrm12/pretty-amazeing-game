class Character {
  // character icon
  PShape icon;
  
  // icon width & height
  float iconW, iconH;
  
  // coordinates in the maze grid
  int posx, posy;
  
  // global coordinates
  Vec2 pos;
  //float offsetX, offsetY;
  
  // direction the icon should face
  float dir, prevDir;
  
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
  }
  
  void setCoords(Maze maze, int newx, int newy) {
    // Check if position is possible
    if (isValidPos(maze, newx, newy)) {
      this.posx = newx;
      this.posy = newy;
      this.pos = maze.tileCoords(newx, newy, "CENTER");
    }
  }
  
  void changeDir(int newx, int newy) {
    float newDir = 0;
    
    if (newx - this.posx == -1) {
      //this.offsetX = 0;
      //this.offsetY = 0;
      newDir = 3 * PI / 2;
    } else if (newx - this.posx == 1) {
      newDir = PI / 2;
    } else if (newy - this.posy == -1) {
      newDir = 0;
    } else if (newy - this.posy == 1) {
      newDir = PI;
    }
    
    this.dir = newDir - this.prevDir;
    //println(this.dir);
  }
  
  void draw(Maze maze) {
    // Update position first
    move(maze);
    
    // Get current position coordinates
    Vec2 coords = maze.tileCoords(this.posx, this.posy, "CENTER");
    
    // Draw icon
    pushMatrix();
    fill(cPersianGreen);
    stroke(cPersianGreen);
    setIconColor(cPersianGreen);
    
    shapeMode(CENTER);
    //this.icon.rotate(this.dir); // TODO
    
    //if (this.dir == PI / 2) {
    //  coords = maze.tileCoords(this.posx - 1, this.posy, "CENTER");
    //  println("right");
    //} else if (this.dir == PI) {
    //  coords = maze.tileCoords(this.posx - 1, this.posy - 1, "CENTER");
    //  println("down");
    //} else if (this.dir == 3 * PI / 2) {
    //  coords = maze.tileCoords(this.posx, this.posy - 1, "CENTER");
    //  println("left");
    //} else {
    //  coords = maze.tileCoords(this.posx, this.posy, "CENTER");
    //  println("up");
    //}
    
    this.prevDir = this.dir;
    this.dir = 0;
    shape(this.icon, coords.x, coords.y, this.iconW, this.iconH);
    //shape(this.icon, this.pos.x, this.pos.y, this.iconW, this.iconH);
    shapeMode(CORNER);
    popMatrix();
  }
  
  void move(Maze maze) {
    int newx = this.posx;
    int newy = this.posy;
    
    if (app.wasKeyPressed('w')) {
      newy = this.posy - 1;
    } else if (app.wasKeyPressed('a')) {
      newx = this.posx - 1;
    } else if (app.wasKeyPressed('s')) {
      newy = this.posy + 1;
    } else if (app.wasKeyPressed('d')) {
      newx = this.posx + 1;
    }
    
    if (newx == this.posx && newy == this.posy) {
      return;
    }
    
    // Check if move is possible
    if (isValidMove(maze, newx, newy)) {
      changeDir(newx, newy);
      this.posx = newx;
      this.posy = newy;
    }
  }
  
  boolean isValidPos(Maze maze, int newx, int newy) {
    // 1. Check if newx/newy is out of bounds
    if (!maze.isInBounds(newx, newy)) return false;
    
    // 2. Check if tile is wall or path
    if (!maze.isPath(newx, newy)) return false;
    
    // 4. If we pass the above tests, the move is valid
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
