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
    pattern();
    
    
    { // If we're below a certain size, we want to fade out the scene buttons, so
      // we'll do that by rendering a translucent black rect over them.
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / height2, 0, 1);
      float alpha = (1 - t) * 255;
      
      fill(CP.background, alpha);
      noStroke();
      rect(bounds.x + 2, bounds.y + 2, bounds.w - 2, bounds.h - 2);
      //rect(bounds.x + bounds.w / 8, bounds.y + bounds.h / 4, 3 * bounds.w / 4, bounds.h / 2);
    }
    
    { // Draw options label
      Vec2 pos1 = bounds.getCenter();
      Vec2 pos2 = bounds.getCenter().sub(new Vec2(0, bounds.h / 4));
      Vec2 pos = pos1;
      
      float size1 = bounds.h * 0.618;
      float size2 = bounds.h / 9;
      float size = size1;
      
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / height2, 0, 1);
      
      if (bounds.h > height1) {
        pos = pos1.lerp(pos2, t);
        size = lerp(size1, size2, t);
      }
      
      fill(CP.lightText);
      textFont(createFont(FC.font, 1));
      textAlign(CENTER, CENTER);
      textSize(size);
      text("Options", pos.x, pos.y-5);
    }
  }
  
  void pattern() {
    ButtonPattern bp = new ButtonPattern(bounds.x, bounds.y, bounds.w, bounds.h);
    bp.displayMain();
  }
}
