class SceneLevel1 extends Scene {
  SceneLevelSelect levelSelect;
  TextButton backButton;
  
  SceneLevel1(SceneLevelSelect levelSelect) {
    super(levelSelect.app);
    this.levelSelect = levelSelect;
    this.backButton = new TextButton("Back");
  }
  
  void tick() {
    boolean controlsActive = (bounds.w > 500);
    
    if (controlsActive) {
      // Check for back button
      backButton.tick();
      if (backButton.wasClicked) {
        levelSelect.goToLevelSelect();
      }
    }
  }
  
  void draw() {
    // Draw the white background
    fill(255);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    
    { // Draw the back button
      float offsetX = bounds.x + 1.0 / 24 * bounds.w;
      float offsetY = bounds.y + 1.0 / 24 * bounds.w;
      float sizeX = 1.0 / 8.0 * bounds.w;
      float sizeY = 0.5 / 6.0 * bounds.h;
      float tSize = 0.12 / 8.0 * bounds.w;
      
      backButton.bounds = new Rect(offsetX, offsetY, sizeX, sizeY);
      backButton.textSize = tSize;
      backButton.draw();
    }
    
    // Draw the dummy text
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(bounds.h / 5);
    text("Level 1", bounds.getCenter().x, bounds.getCenter().y);
  }
}
