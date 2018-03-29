class SceneMainMenu extends Scene {
  SceneLevelSelect levelSelect;
  SmoothFloat levelSelectZoom;
  
  SceneMainMenu(App app) {
    super(app);
    this.levelSelect = new SceneLevelSelect(this);
    this.levelSelectZoom = new SmoothFloat(0.0, 1.0);
  }
  
  void tick() {
    // Animate between the Main Menu and Level Select scenes by clicking the mouse
    levelSelectZoom.tick(app.deltaTime);
    if (app.wasMouseClicked() && levelSelectZoom.isStable()) {
      if (levelSelectZoom.value == 0) {
        levelSelectZoom.animateTo(1);
      } else {
        levelSelectZoom.animateTo(0);
      }
    }
    
    // Update the level select zoom & bounds
    Vec2 minSize = new Vec2(100, 50);
    levelSelect.zoom = (sin((levelSelectZoom.value - 0.5) * PI) + 1) / 2; // Use sin() to smooth out the linear transition
    levelSelect.bounds.w = minSize.x + (bounds.w - minSize.x) * levelSelect.zoom;
    levelSelect.bounds.h = minSize.y + (bounds.h - minSize.y) * levelSelect.zoom;
    levelSelect.bounds.x = bounds.x + bounds.w / 2 - levelSelect.bounds.w / 2;
    levelSelect.bounds.y = bounds.y + bounds.h / 2 - levelSelect.bounds.h / 2;
  }
  
  void draw() {
    fill(255);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    
    this.levelSelect.draw();
  }
}
