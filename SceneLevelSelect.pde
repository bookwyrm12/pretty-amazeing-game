class SceneLevelSelect extends Scene {
  SceneMainMenu mainMenu;
  SceneButtonList sceneButtons;
  TextButton backButton;
  
  SceneLevelSelect(SceneMainMenu mainMenu) {
    super(mainMenu.app);
    this.mainMenu = mainMenu;
    this.sceneButtons = new SceneButtonList(this);
    this.sceneButtons.relPadding = new Vec2(0.065, 0);
    this.sceneButtons.createButton("level 1", new SceneLevel1(this));
    this.sceneButtons.createButton("level 2", new SceneLevel2(this));
    this.sceneButtons.createButton("level 3", new SceneLevel3(this));
    this.backButton = new TextButton("Back");
    this.backButton.rectColor = color(255);
    this.backButton.textColor = color(0);
  }
  
  void tick() {
    // Update the zoom & logic for scenes
    sceneButtons.tick();
    
    // We will enable button controls only when we are the active scene
    boolean controlsActive = (this.bounds.w > 500) && sceneButtons.areAllButtonsZoomedOut(0.1);
    
    // Check for button clicks
    if (controlsActive) {
      
      // Check for level selection
      sceneButtons.handleClicks();
      
      // Check for back button
      backButton.tick();
      if (backButton.wasClicked) {
        mainMenu.goToMainMenu();
      }
    }
  }
  
  void draw() {
    pattern();
    
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
    
    // Draw the scene buttons
    sceneButtons.draw();
    
    { // If we're below a certain size, we want to fade out the buttons, so
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
      
      textFont(createFont(FC.font, 1));
      float textAlpha = 255 * (1 - sceneButtons.getMaxButtonEasedZoom());
      fill(CP.lightText, textAlpha);
      textAlign(CENTER, CENTER);
      textSize(size);
      text("Play", pos.x, pos.y-5);
    }
  }
  
  void goToLevelSelect() {
    sceneButtons.zoomOutAllButtons();
  }
  
  void pattern() {
    ButtonPattern bp = new ButtonPattern(bounds.x, bounds.y, bounds.w, bounds.h);
    bp.displayMain();
    
    pushMatrix();
    translate(bounds.x, bounds.y);
    SetLineTrees lt = new SetLineTrees(bounds.w, bounds.h);
    lt.display();
    popMatrix();
  }
}
