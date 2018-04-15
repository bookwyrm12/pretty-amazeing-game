class SceneLevel2 extends Scene {
  SceneLevelSelect levelSelect;
  
  SceneLevel2(SceneLevelSelect levelSelect) {
    super(levelSelect.app);
    this.levelSelect = levelSelect;
  }
  
  void tick() {
    boolean controlsActive = (bounds.w > 500);
    
    if (controlsActive && app.wasMouseClicked()) {
      this.levelSelect.goToLevelSelect();
    }
  }
  
  void draw() {
    fill(255);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(bounds.h / 5);
    text("Level 2", bounds.getCenter().x, bounds.getCenter().y);
  }
}
