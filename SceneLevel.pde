class SceneLevel extends Scene {
  int id, wCells, hCells;
  Vec2 mazePos;
  Maze maze;
  
  SceneLevel(App app, int id) {
    super(app);
    this.id      = id;
    setMazeSize(this.id);
    this.mazePos = new Vec2(200, 100);
    this.maze    = new Maze(this.wCells, this.hCells, this.mazePos);
  }
  
  void setMazeSize(int id) {
    this.wCells = 18 + (id * 2);
    this.hCells = 18 + (id * 2);
  }
  
  void draw(CharacterPlayer player) {
    // Draw background
    
    // Draw maze
    maze.draw(player);
  }
}
