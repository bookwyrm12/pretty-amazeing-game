class SceneMainMenu extends Scene {
  SceneLevelSelect levelSelectScene;
  SmoothFloat      levelSelectZoom;
  Rect             levelSelectMinRect;
  SceneOptions     optionsScene;
  SmoothFloat      optionsZoom;
  Rect             optionsMinRect;
  
  SceneMainMenu(App app) {
    super(app);
    this.levelSelectScene   = new SceneLevelSelect(this);
    this.levelSelectZoom    = new SmoothFloat(0.0, 0.8);
    this.levelSelectMinRect = new Rect(
      this.bounds.getCenter().x - 100 / 2,
      this.bounds.getCenter().y - 50 / 2,
      100,
      50
    );
    this.optionsScene   = new SceneOptions(this);
    this.optionsZoom    = new SmoothFloat(0.0, 0.8);
    this.optionsMinRect = new Rect(
      this.bounds.getCenter().x - 100 / 2,
      this.levelSelectMinRect.getMaxY() + 40,
      100,
      50
    );
  }
  
  void tick() {
    // We will enable button controls only when we are entirely in the main menu
    boolean controlsActive = (levelSelectZoom.isStable() &&
                              levelSelectZoom.value == 0 &&
                              optionsZoom.isStable() &&
                              optionsZoom.value == 0);
    
    // Animate between the Main Menu and Level Select scenes by clicking "Play"
    if (controlsActive) {
      Vec2    mousePos          = app.getMousePos();
      boolean mouseClicked      = app.wasMouseClicked();
      boolean mouseWithinBounds = levelSelectScene.bounds.contains(mousePos);
      
      if (mouseClicked && mouseWithinBounds) {
        goToLevelSelect();
      }
    }
    
    // Animate between the Main Menu and Options scenes by clicked "Options"
    if (controlsActive) {
      Vec2    mousePos          = app.getMousePos();
      boolean mouseClicked      = app.wasMouseClicked();
      boolean mouseWithinBounds = optionsScene.bounds.contains(mousePos);
      
      if (mouseClicked && mouseWithinBounds) {
        goToOptions();
      }
    }
    
    // Update the zoom & bounds for the scenes
    levelSelectZoom.tick(app.deltaTime);
    levelSelectScene.zoom = easeInOutCubic(levelSelectZoom.value);
    levelSelectScene.bounds = levelSelectMinRect.lerp(this.bounds, levelSelectScene.zoom);
    
    optionsZoom.tick(app.deltaTime);
    optionsScene.zoom = easeInOutCubic(optionsZoom.value);
    optionsScene.bounds = optionsMinRect.lerp(this.bounds, optionsScene.zoom);
    
    // Update the other scenes
    levelSelectScene.tick();
    optionsScene.tick();
  }
  
  void draw() {
    fill(255);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    
    if (levelSelectScene.zoom > 0) {
      optionsScene.draw();
      levelSelectScene.draw();
    } else {
      levelSelectScene.draw();
      optionsScene.draw();
    }
  }
  
  void goToMainMenu() {
    if (levelSelectZoom.value > 0) {
      levelSelectZoom.animateTo(0);
    }
    if (optionsZoom.value > 0) {
      optionsZoom.animateTo(0);
    }
  }
  
  void goToLevelSelect() {
    if (levelSelectZoom.value < 1) {
      levelSelectZoom.animateTo(1);
    }
    if (optionsZoom.value > 0) {
      optionsZoom.animateTo(0);
    }
  }
  
  void goToOptions() {
    if (levelSelectZoom.value > 0) {
      levelSelectZoom.animateTo(0);
    }
    if (optionsZoom.value < 1) {
      optionsZoom.animateTo(1);
    }
  }
  
  // Stolen from: https://gist.github.com/gre/1650294
  private float easeInOutCubic(float t) {
    return t<.5 ? 4*t*t*t : (t-1)*(2*t-2)*(2*t-2)+1;
  }
}
