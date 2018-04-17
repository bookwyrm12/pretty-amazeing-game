class SceneLevel extends Scene {
  int id, wCells, hCells;
  Vec2 mazePos;
  Maze maze;
  SceneLevelSelect levelSelect;
  MazeGenerator gen;
  boolean levelOn;
  
  SceneLevel(SceneLevelSelect levelSelect, int id) {
    super(levelSelect.app);
    this.levelSelect = levelSelect;
    this.id          = id;
    setMazeSize(this.id);
    this.mazePos     = new Vec2(200, 100);
    this.maze        = new Maze(this.wCells, this.hCells, this.mazePos);
    this.gen         = new MazeGenerator();
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
    
    // TODO
    { // Draw the maze
      int height1 = 100; // 300
      int height2 = 400; // 600
      float t = constrain((bounds.h - height1) / (height2 - height1), 0, 1);
      
      if (t > 0) {
        // Set player coordinates to beginning of maze when starting the level
        if (!this.levelOn) {
          player.setCoords(maze, this.maze.startX, this.maze.startY);
          this.levelOn = true;
        }
        
        if (this.maze.endX == player.posx && this.maze.endY == player.posy) {
          player.completeLevel(this.id);
          println("Nice! You completed Level " + this.id);
          player.resetPos(this.maze);
          this.levelSelect.goToLevelSelect();
        }
        this.maze.draw(player, t);
      } else {
        this.levelOn = false;
      }
    }
    
    { // 
      
    }
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
    // Keep all levels the same size for now. This keeps
    // the UI looking pretty, and we don't have to worry
    // about moving the maze location around to recenter it.
    this.wCells = 20;
    this.hCells = 20;
    
    // Old code, changing the maze size based on the level.
    // ie. Higher level = bigger = harder maze
    //this.wCells = 18 + (id * 2);
    //this.hCells = 18 + (id * 2);
  }
  
  //void draw(CharacterPlayer player) {
  //  // Draw background
    
  //  // Draw maze
  //  maze.draw(player);
  //}
}
