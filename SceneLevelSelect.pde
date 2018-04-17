class SceneLevelSelect extends Scene {
  SceneMainMenu mainMenu;
  SceneButtonList sceneButtons;
  CircleButton backButton;
  
  SceneLevelSelect(SceneMainMenu mainMenu) {
    super(mainMenu.app);
    this.mainMenu = mainMenu;
    this.sceneButtons = new SceneButtonList(this);
    this.sceneButtons.relPadding = new Vec2(0.065, 0);
    this.sceneButtons.createButton("level 1", new SceneLevel1(this));
    this.sceneButtons.createButton("level 2", new SceneLevel2(this));
    this.sceneButtons.createButton("level 3", new SceneLevel3(this));
    this.backButton = new CircleButton(0, 0, 0, 0, 255, 255);
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
      float offsetX = bounds.x + 1.0 / 20 * bounds.w;
      float offsetY = bounds.y + 1.0 / 20 * bounds.w;
      float sizeY = 0.5 / 8.0 * bounds.h;
      
      // We only want to render the button when the scene is active
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / (height2 - height1), 0, 1);
      float tAlpha = (1 - t) * 255;
      
      backButton.bounds(offsetX, offsetY, sizeY, sizeY, CP.background, CP.line);
      backButton.displayBackMain();
    }
    
    // Draw the scene buttons
    sceneButtons.draw();
    
    { // If we're below a certain size, we want to fade out the buttons, so
      // we'll do that by rendering a translucent black rect over them.
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / (height2 - height1), 0, 1);
      float alpha = (1 - t) * 255;
      
      // The rect should only cover the scene buttons. We'll have to expand the rect
      // slightly to account for the additional octagon pattern around the buttons
      Rect r = sceneButtons.getBounds();
      r.x -= 10;
      r.y -= 10;
      r.w += 20;
      r.h += 20;
      
      fill(CP.background, alpha);
      noStroke();
      rect(r.x, r.y, r.w, r.h);
    }
    
    { // Draw play label
      Vec2 pos1 = bounds.getCenter();
      Vec2 pos2 = bounds.getCenter().sub(new Vec2(0, bounds.h / 4));
      Vec2 pos = pos1;
      
      float size1 = bounds.h * 0.618;
      float size2 = bounds.h / 9;
      float size = size1;
      
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / (height2 - height1), 0, 1);
      
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
