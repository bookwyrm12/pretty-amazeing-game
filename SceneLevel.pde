class SceneLevel extends Scene {
  int id, wCells, hCells;
  Vec2 mazePos;
  Maze maze;
  SceneLevelSelect levelSelect;
  
  SceneLevel(SceneLevelSelect levelSelect, int id) {
    super(levelSelect.app);
    this.levelSelect = levelSelect;
    this.id          = id;
    setMazeSize(this.id);
    this.mazePos     = new Vec2(200, 100);
    this.maze        = new Maze(this.wCells, this.hCells, this.mazePos);
  }
  
  void tick() {
    boolean controlsActive = (bounds.w > 500);
    
    if (controlsActive && app.wasMouseClicked()) {
      this.levelSelect.goToLevelSelect();
    }
  }
  
  void draw() {
  //void draw(CharacterPlayer player) {
    fill(255);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(bounds.h / 5);
    text(("Level " + this.id), bounds.getCenter().x, bounds.getCenter().y);
    maze.draw(player);
  }
  
  // Old stuff
  
  //SceneLevel(App app, int id) {
  //  super(app);
  //  this.id      = id;
  //  setMazeSize(this.id);
  //  this.mazePos = new Vec2(200, 100);
  //  this.maze    = new Maze(this.wCells, this.hCells, this.mazePos);
  //}
  
  void setMazeSize(int id) {
    this.wCells = 18 + (id * 2);
    this.hCells = 18 + (id * 2);
  }
  
  //void draw(CharacterPlayer player) {
  //  // Draw background
    
  //  // Draw maze
  //  maze.draw(player);
  //}
}
