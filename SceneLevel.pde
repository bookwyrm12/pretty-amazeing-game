class SceneLevel extends Scene {
  Maze maze;
  
  SceneLevel(App app, int w, int h) {
    super(app);
    this.maze = new Maze(w, h);
  }
  
  void draw() {
    // Draw background
    
    // Draw maze
    // maze.draw();
  }
}
