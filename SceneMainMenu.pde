class SceneMainMenu extends Scene {
  SceneButtonList sceneButtons;
  
  SceneMainMenu(App app) {
    super(app);
    this.sceneButtons = new SceneButtonList(this);
    this.sceneButtons.createButton("level select", new SceneLevelSelect(this));
    this.sceneButtons.createButton("options", new SceneOptions(this));
  }
  
  void tick() {
    // Update the zoom & logic for scenes
    sceneButtons.tick();
    
    // We will enable button controls only when we are the active scene
    boolean controlsActive = sceneButtons.areAllButtonsZoomedOut(0.1);
    
    // Check for button clicks
    if (controlsActive) {
      sceneButtons.handleClicks();
    }
  }
  
  void draw() {
    fill(255);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    sceneButtons.draw();
  }
  
  void goToMainMenu() {
    sceneButtons.zoomOutAllButtons();
  }
}
