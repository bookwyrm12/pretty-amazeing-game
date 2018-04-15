class SceneOptions extends Scene {
  SceneMainMenu mainMenu;
  
  SceneOptions(SceneMainMenu mainMenu) {
    super(mainMenu.app);
    this.mainMenu = mainMenu;
  }
  
  void tick() {
    boolean controlsActive = (bounds.w > 500);
    
    if (controlsActive && app.wasMouseClicked()) {
      this.mainMenu.goToMainMenu();
    }
  }
  
  void draw() {
    fill(0);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(bounds.h / 5);
    text("Options", bounds.getCenter().x, bounds.getCenter().y);
  }
}
