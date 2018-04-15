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
    
    // TODO: replace this
    // We will enable button controls only when we are entirely in the main menu
    boolean controlsActive = true;
    for (SceneButton button : sceneButtons.buttons) {
      if (button.zoom.isStable() && button.zoom.value == 0) {
        continue;
      }
      controlsActive = false;
    }
    
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
    // TODO: replace this
    // Zoom out of all scenes
    for (SceneButton button : sceneButtons.buttons) {
      if (button.zoom.value != 0) {
        button.zoom.animateTo(0);
      }
    }
  }
}
