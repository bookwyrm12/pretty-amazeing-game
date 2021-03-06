class SceneLevel extends Scene {
  int id, wCells, hCells;
  Vec2 mazePos;
  Maze maze;
  SceneLevelSelect levelSelect;
  MazeGenerator gen;
  boolean levelOn, levelComplete;
  CircleButton backButton;
  
  SceneLevel(SceneLevelSelect levelSelect, int id) {
    super(levelSelect.app);
    this.levelSelect = levelSelect;
    this.id          = id;
    setMazeSize(this.id);
    this.mazePos     = new Vec2(200, 100);
    this.maze        = new Maze(this.wCells, this.hCells, this.mazePos);
    this.gen         = new MazeGenerator();
    this.backButton = new CircleButton(0, 0, 0, 0, 255, 255);
    this.levelComplete = player.hasCompletedLevel(this.id);
  }
  
  void tick() {
    boolean controlsActive = (bounds.w > 500);
    
    if (controlsActive){
      // Check for back button
      backButton.tick();
      if (backButton.wasClicked) {
        this.levelSelect.goToLevelSelect();
      }
    }
  }
  
  void draw() {
    ButtonPattern bp = new ButtonPattern(bounds.x, bounds.y, bounds.w, bounds.h);
    if (!levelComplete) {
      bp.displayLevel();
    } else {
      bp.displayLevelComplete();
    }
    pattern();
    
    { // Draw the back button
      float offsetX = bounds.x + 1.0 / 20 * bounds.w;
      float offsetY = bounds.y + 1.0 / 20 * bounds.w;
      float sizeY = 0.5 / 8.0 * bounds.h;
      
      // We only want to render the button when the scene is active
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / (height2 - height1), 0, 1);
      float tAlpha = t * 255;
      
      backButton.bounds(offsetX, offsetY, sizeY, sizeY, CP.lightText, CP.darkText);
      backButton.alpha = tAlpha;
      backButton.displayBackLevel();
    }
    
    { // Draw level label
      Vec2 pos1 = bounds.getCenter();
      Vec2 pos2 = bounds.getCenter().sub(new Vec2(0, bounds.h * 13 / 32));
      Vec2 pos = pos1;
      
      float size1 = bounds.h * 0.618;
      float size2 = bounds.h / 9;
      float size = size1;
      
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / (height2 - height1), 0, 1);
      
      if (bounds.h > height1) {
        pos = pos1.lerp(pos2, t);
        size = lerp(size1, size2, t);
      }
      
      fill(CP.darkText);
      textFont(createFont(FC.font, 1));
      textAlign(CENTER, CENTER);
      textSize(size);
      text("Level " + this.id, pos.x, pos.y-5);
    }
    
    // TODO
    { // Draw the maze
      int height1 = 100; //100; // 300
      int height2 = 600; //400; // 600
      float t = constrain((bounds.h - height1) / (height2 - height1), 0, 1);
      float tAlpha = t * 255;
      
      this.maze.alpha = tAlpha;
      
      if (t > 0) {
        // Center the maze
        this.maze.setPositionFromCenter(bounds.getCenter());
        
        // Set player coordinates to beginning of maze when starting the level
        if (!this.levelOn) {
          player.setCoords(maze, this.maze.startX, this.maze.startY);
          this.levelOn = true;
        }
        
        // Level complete
        if (this.maze.endX == player.posx && this.maze.endY == player.posy) {
          player.completeLevel(this.id);
          this.levelComplete = true;
          println("Nice! You beat Level " + this.id);
          player.resetPos(this.maze);
          this.levelSelect.goToLevelSelect();
        }
        
        // Draw maze
        this.maze.draw(player, t);
        
      } else {
        this.levelOn = false;
      }
    }
  }
  
  void pattern() {
    for(int i = 0; i < 5; i++) {
      for(int j = 0; j < 4; j++) {
        if((j == 1 || j == 2) && (i > 0 && i < 4)) {
        }else {Squares s = new Squares(bounds.x + bounds.w/10 + (i)*bounds.w/5, bounds.y 
            + bounds.h/8 + (j)*bounds.h/4, bounds.h/20, CP.darkText, CP.lightText);
        s.display();}
      }
    }
  }
  
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
}
