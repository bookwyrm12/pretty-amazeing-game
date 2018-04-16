class SceneLevel1 extends Scene {
  SceneLevelSelect levelSelect;
  
  SceneLevel1(SceneLevelSelect levelSelect) {
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
    ButtonPattern bp = new ButtonPattern(bounds.x, bounds.y, bounds.w, bounds.h);
    bp.displayLevel();
    fill(#46351D);
    textFont(createFont(FC.font, 1));
    textAlign(CENTER, CENTER);
    textSize(bounds.h*0.618);
    text("Level 1", bounds.getCenter().x, bounds.getCenter().y-5);
  }
}
