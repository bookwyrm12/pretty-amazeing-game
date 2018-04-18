class Maze {
  class Tile {
    boolean solid     = true;
    boolean northWall = true;
    boolean eastWall  = true;
    boolean southWall = true;
    boolean westWall  = true;
    String debug;
  }
  
  int width, height;
  float cellW, cellH;
  final float mazeW = 400;
  final float mazeH = 400;
  Vec2 pos;
  Tile[][] tiles;
  int seed;
  int startX, startY;
  int endX, endY;
  
  Maze(int width, int height, Vec2 pos) {
    this.width  = width;
    this.height = height;
    this.cellW  = this.mazeW / width;
    this.cellH  = this.mazeH / height;
    this.pos    = pos;
    this.tiles  = new Tile[width][height];
    this.resetTiles();
  }
  
  void resetTiles() {
    for (int x = 0; x < this.width; ++x) {
      for (int y = 0; y < this.height; ++y) {
        tiles[x][y] = new Tile();
      }
    }
  }
  
  void draw(CharacterPlayer player) {
    draw(player, 1);
  }
  
  void draw(CharacterPlayer player, float scaleFactor) {
    float s = 20;
    pushMatrix();
    //translate(s, s);
    Vec2 mazeSize = new Vec2(mazeW, mazeH);
    Vec2 mazeCenter = pos.add(mazeSize.div(2));
    Vec2 topLeftWithScale = mazeCenter.sub(mazeSize.mult(scaleFactor / 2));
    translate(topLeftWithScale.x, topLeftWithScale.y);
    
    // Scale needs to be kept separate from the transform because text cannot
    // be drawn when a scale is applied
    pushMatrix();
    scale(scaleFactor);
    
    // Draw the tiles
    noStroke();
    for (int x = 0; x < this.width; ++x) {
      for (int y = 0; y < this.height; ++y) {
        Tile t = tiles[x][y];
        if (t.solid) {
          fill(0);
        } else {
          fill(255);
        }
        rect(x * s, y * s, s, s);
        
      }
    }
    
    // Draw the walls (done separately so that the walls are always on top)
    stroke(0);
    for (int x = 0; x < this.width; ++x) {
      for (int y = 0; y < this.height; ++y) {
        Tile t = tiles[x][y];
        if (t.solid) {
          continue;
        }
        pushMatrix();
        translate(x * s, y * s);
        if (t.northWall) {
          line(0, s, s, s);
        }
        if (t.southWall) {
          line(0, 0, s, 0);
        }
        if (t.eastWall) {
          line(s, 0, s, s);
        }
        if (t.westWall) {
          line(0, 0, 0, s);
        }
        popMatrix();
      }
    }
    popMatrix();
    
    // Draw the debug text
    for (int x = 0; x < this.width; ++x) {
      for (int y = 0; y < this.height; ++y) {
        Tile t = tiles[x][y];
        if (t.debug != null) {
          fill(t.solid ? 255 : 0);
          textAlign(CENTER, CENTER);
          textSize(10);
          text(t.debug, (x * s + s/2) * scaleFactor, (y * s + s/2) * scaleFactor);
        }
      }
    }
    
    popMatrix();
	
    // Draw player
    player.draw(this, scaleFactor);
  }
  
  void colorTile(int posx, int posy, color c, int alpha) {
    // Set color
    fill(c, alpha);
    stroke(c, alpha);
    
    Vec2 coords = tileCoords(posx, posy, "CENTER");
    ellipse(coords.x, coords.y, this.cellW, this.cellH);
  }
  
  void printDebug() {
    StringDict strings = new StringDict();
    for (int x = 0; x < this.width; ++x) {
      for (int y = 0; y < this.height; ++y) {
        Maze.Tile t = this.tiles[x][y];
        if (!t.solid) {
          strings.set(t.debug, (t.northWall?"t ":"f ") + (t.eastWall?"t ":"f ") + (t.southWall?"t ":"f ") + (t.westWall?"t":"f"));
        }
      }
    }
    strings.sortKeys();
    for (String k : strings.keyArray()) {
      println(k + ":", strings.get(k));
    }
  }
  
  void saveMazeFile() {
    int numCells = (this.width * this.height) + 1;
    String[] mazedata = new String[numCells];
    int i = 0;
    mazedata[i] = "x | y | solid | n | e | s | w";
    i++;
    for (int x = 0; x < this.width; x++) {
      for (int y = 0; y < this.height; y++) {
        Maze.Tile t = this.tiles[x][y];
        String loc = x + " | " + y + " | ";
        mazedata[i] = loc + (t.solid?"wall | ":"path | ") + (t.northWall?"t | ":"f | ") + (t.eastWall?"t | ":"f | ") + (t.southWall?"t | ":"f | ") + (t.westWall?"t":"f");
        i++;
      }
    }
    saveStrings(this.seed + "-mazedata.txt", mazedata);
  }
  
  boolean isInBounds(int posx, int posy) {
    if (posx < 0 || posx >= width) return false;
    if (posy < 0 || posy >= height) return false;
    return true;
  }
  
  boolean isPath(int posx, int posy) {
    return !this.tiles[posx][posy].solid;
  }
  
  boolean isWallBetween(int posx, int posy, int newx, int newy) {
    if (newx - posx == -1) return this.tiles[posx][posy].westWall;
    if (newx - posx == 1) return this.tiles[posx][posy].eastWall;
    if (newy - posy == -1) return this.tiles[posx][posy].southWall;
    if (newy - posy == 1) return this.tiles[posx][posy].northWall;
    return false;
  }
  
  Vec2 tileCoords(int posx, int posy, String mode) {
    return tileCoords(posx, posy, mode, 1);
  }
  
  Vec2 tileCoords(int posx, int posy, String mode, float scaleFactor) {
    Vec2 mazeSize = new Vec2(mazeW, mazeH);
    Vec2 mazeCenter = pos.add(mazeSize.div(2));
    Vec2 topLeftWithScale = mazeCenter.sub(mazeSize.mult(scaleFactor / 2));
    
    Vec2 coords = new Vec2();
    if (mode == "CENTER") {
      coords.x = topLeftWithScale.x + ((posx * this.cellW) + (this.cellW / 2)) * scaleFactor;
      coords.y = topLeftWithScale.y + ((posy * this.cellH) + (this.cellH / 2)) * scaleFactor;
    } else { // if (mode == "CORNER") {
      coords.x = topLeftWithScale.x + (posx * this.cellW) * scaleFactor;
      coords.y = topLeftWithScale.y + (posy * this.cellH) * scaleFactor;
    }
    return coords;
  }
  
  void setPositionFromCenter(Vec2 center) {
    Vec2 size = new Vec2(mazeW, mazeH);
    Vec2 topLeft = center.sub(size.div(2));
    this.pos = topLeft;
  }
  
  //int[] gridCoords(Vec2 pos, String mode) {
  //  int[] coords = new int[2];
  //  if (mode == "CENTER") {
  //    coords[0] = int((pos.x - this.pos.x) / this.cellW);
  //    coords[1] = int((pos.y - this.pos.y) / this.cellH);
  //    //coords[0] = this.pos.x + (pos.x * this.cellW) + (this.cellW / 2);
  //    //coords[1] = this.pos.y + (pos.y * this.cellH) + (this.cellH / 2);
  //  } else { // if (mode == "CORNER") {
  //    coords[0] = int((pos.x - this.pos.x) / this.cellW);
  //    coords[1] = int((pos.y - this.pos.y) / this.cellH);
  //  }
  //  return coords;
  //}
}
