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
}
