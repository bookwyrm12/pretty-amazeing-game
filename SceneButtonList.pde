class SceneButtonList {
  // The scene is important because we need the bounds to make a Scene
  // fullscreen when clicked on
  Scene scene;
  
  // This is the relative size of the buttons with respect to the scene bounds
  Vec2 relSize;
  
  // This is the relative padding between buttons (horizontal and vertical
  // padding) with respect to the scene bounds
  Vec2 relPadding;
  
  // Obviously we need to store the buttons
  ArrayList<SceneButton> buttons;
  
  
  SceneButtonList(Scene scene) {
    this.scene      = scene;
    this.relSize    = new Vec2(0.125, 0.09);
    this.relPadding = new Vec2(0,     0.065);
    this.buttons    = new ArrayList<SceneButton>();
  }
  
  // This was separate from tick() so that the scene can determine when to
  // activate the buttons, while still scaling the buttons every frame.
  // Returns true if button was clicked.
  boolean handleClicks() {
    
    Vec2    mousePos     = app.getMousePos();
    boolean mouseClicked = app.wasMouseClicked();
    if (!mouseClicked) {
      return false;
    }
    
    for (SceneButton button : buttons) {
      boolean mouseWithinBounds = button.scene.bounds.contains(mousePos);
      
      // If clicked, zoom in on that scene
      if (mouseWithinBounds) {
        button.zoom.animateTo(1);
        return true;
      }
    }
    return false;
  }
  
  void tick() {
    // Update the zoom for the scenes
    for (SceneButton button : buttons) {
      button.zoom.tick(app.deltaTime);
    }
    
    // Update the logic for the scenes
    for (SceneButton button : buttons) {
      button.scene.tick();
    }
  }
  
  void draw() {
    // The buttons size and position is influenced by the size of the containing
    // scene, so we will recalculate this every frame
    positionAndScaleButtons();
    
    // Sort the buttons by zoom so that the "active" scene is rendered last
    // (and in front of the rest)
    ArrayList<SceneButton> sortedButtons = sortButtons();
    
    // Draw the buttons
    for (SceneButton button : sortedButtons) {
      button.scene.draw();
    }
  }
  
  void createButton(String name, Scene scene) {
    SceneButton button = new SceneButton(name, scene);
    buttons.add(button);
  }
  
  ArrayList<SceneButton> sortButtons() {
    // Stolen from: https://trinisoftinc.wordpress.com/2012/03/29/simple-sorting-algorithms-implementations-part-1/
    
    ArrayList<SceneButton> sortedButtons = (ArrayList)this.buttons.clone();
    for (int i = 1; i < sortedButtons.size(); ++i) {
      SceneButton b1 = sortedButtons.get(i);
      int j = i - 1;
      while (j >= 0 && sortedButtons.get(j).compareTo(b1) > 0) {
        sortedButtons.set(j + 1, sortedButtons.get(j));
        --j;
      }
      sortedButtons.set(j + 1, b1);
    }
    return sortedButtons;
  }
  
  /*SceneButton findButtonByName(String name) {
    for (SceneButton button : buttons) {
      if (button.name.equals(name)) {
        return button;
      }
    }
    return null;
  }*/
  
  void positionAndScaleButtons() {
    
    // Scale
    for (SceneButton button : buttons) {
      float w1 = this.scene.bounds.w * relSize.x;
      float w2 = this.scene.bounds.w;
      button.scene.bounds.w = lerp(w1, w2, button.easedZoom());
      
      float h1 = this.scene.bounds.h * relSize.y;
      float h2 = this.scene.bounds.h;
      button.scene.bounds.h = lerp(h1, h2, button.easedZoom());
    }
    
    { // Position horizontally
      Vec2 center = scene.bounds.getCenter();
      
      if (relPadding.x == 0) {
        
        // Without any padding, we can just center the buttons. This will work
        // regardless of zoom.
        for (SceneButton button : buttons) {
          button.scene.bounds.x = center.x - button.scene.bounds.w / 2;
        }
      } else {
        
        // Position w/o zoom
        float eachWidth   = this.scene.bounds.w * relSize.x;
        float eachPadding = this.scene.bounds.w * relPadding.x;
        int   buttonCount = buttons.size();
        float totalWidth  = buttonCount * eachWidth + (buttonCount - 1) * eachPadding;
        
        float currentX = center.x - totalWidth / 2;
        for (SceneButton button : buttons) {
          button.scene.bounds.x = currentX;
          currentX += eachWidth + eachPadding;
        }
        
        // Factor in zoom
        for (SceneButton button : buttons) {
          float x1 = button.scene.bounds.x;
          float x2 = this.scene.bounds.x;
          button.scene.bounds.x = lerp(x1, x2, button.easedZoom());
        }
      }
    }
    
    { // Position vertically
      Vec2 center = scene.bounds.getCenter();
      
      if (relPadding.y == 0) {
        
        // Without any padding, we can just center the buttons. This will work
        // regardless of zoom.
        for (SceneButton button : buttons) {
          button.scene.bounds.y = center.y - button.scene.bounds.h / 2;
        }
      } else {
        
        // Position w/o zoom
        float eachHeight  = this.scene.bounds.h * relSize.y;
        float eachPadding = this.scene.bounds.h * relPadding.y;
        int   buttonCount = buttons.size();
        float totalHeight = buttonCount * eachHeight + (buttonCount - 1) * eachPadding;
        
        float currentY = center.y - totalHeight / 2;
        for (SceneButton button : buttons) {
          button.scene.bounds.y = currentY;
          currentY += eachHeight + eachPadding;
        }
      
        // Factor in zoom
        for (SceneButton button : buttons) {
          float y1 = button.scene.bounds.y;
          float y2 = this.scene.bounds.y;
          button.scene.bounds.y = lerp(y1, y2, button.easedZoom());
        }
      }
    }
  }
}
