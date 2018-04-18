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
    pattern();
    sceneButtons.draw();
  }
  
  void goToMainMenu() {
    sceneButtons.zoomOutAllButtons();
  }
  
  void pattern() {
    ButtonPattern bp = new ButtonPattern(bounds.x, bounds.y, bounds.w, bounds.h);
    bp.displayMain();
    
    // Pattern
    Flower f1 = new Flower(bounds.x + bounds.w, bounds.y + bounds.h, 500, CP.line, CP.fillCol);
    Flower f2 = new Flower(bounds.x, bounds.y, 500, CP.line, CP.fillCol);
    f1.display();
    f2.display();
  }
}
