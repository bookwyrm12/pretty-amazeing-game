class Maze {
  class Tile {
    boolean solid      = true;
    boolean topOpen    = false;
    boolean rightOpen  = false;
    boolean bottomOpen = false;
    boolean leftOpen   = false;
  }
  
  int width;
  int height;
  Tile[][] tiles;
  
  Maze(int width, int height) {
    this.width  = width;
    this.height = height;
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
    // Draw maze
    
    // Draw player
    player.draw(this);
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
    if (newx - posx == -1) return !this.tiles[posx][posy].leftOpen; // this.tiles[posx][posy].westWall;
    if (newx - posx == 1) return !this.tiles[posx][posy].rightOpen; // this.tiles[posx][posy].eastWall;
    if (newy - posy == -1) return !this.tiles[posx][posy].topOpen; // this.tiles[posx][posy].northWall;
    if (newy - posy == 1) return !this.tiles[posx][posy].bottomOpen; // this.tiles[posx][posy].southWall;
    return false;
  }
}
