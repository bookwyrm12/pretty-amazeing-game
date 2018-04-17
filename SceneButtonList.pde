class SceneButtonList {
  // The scene is important because we need the bounds to make a Scene
  // fullscreen when clicked on
  Scene scene;
  
  // This is the relative size of the buttons with respect to the scene bounds
  Vec2 relSize;
  
  // This is the relative padding between buttons (horizontal and vertical
  // padding) with respect to the scene bounds
  Vec2 relPadding;
  
  // Obviously we need to store the buttons (class found at bottom)
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
  
  boolean areAllButtonsZoomedOut(float threshold) {
    for (SceneButton button : buttons) {
      if (button.zoom.value > threshold) {
        return false;
      }
    }
    return true;
  }
  
  void zoomOutAllButtons() {
    for (SceneButton button : buttons) {
      if (button.zoom.value != 0) {
        button.zoom.animateTo(0);
      }
    }
  }
  
  float getMaxButtonEasedZoom() {
    float max = 0;
    for (SceneButton button : buttons) {
      if (max < button.easedZoom()) {
        max = button.easedZoom();
      }
    }
    return max;
  }
  
  Rect getBounds() {
    if (buttons.size() == 0) {
      return null;
    }
    Rect r = buttons.get(0).scene.bounds.copy();
    for (SceneButton button : buttons) {
      if (button.scene.bounds.x < r.x) {
        r.w += r.x - button.scene.bounds.x;
        r.x = button.scene.bounds.x;
      }
      if (button.scene.bounds.y < r.y) {
        r.h += r.y - button.scene.bounds.y;
        r.y = button.scene.bounds.y;
      }
      if (button.scene.bounds.getMaxX() > r.getMaxX()) {
        r.w += button.scene.bounds.getMaxX() - r.getMaxX();
      }
      if (button.scene.bounds.getMaxY() > r.getMaxY()) {
        r.h += button.scene.bounds.getMaxY() - r.getMaxY();
      }
    }
    return r;
  }
  
  private ArrayList<SceneButton> sortButtons() {
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
  
  private void positionAndScaleButtons() {
    
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
  
  
  
  class SceneButton {
  // Used for identifying a scene button within the code
  String name;
  
  // This scene will be rendered/resized by this button
  Scene scene;
  
  // When a scene is clicked on, its sizing is no longer controlled by the
  // SceneButtonList, but instead, it is zoomed in on and made fullscreen. The
  // zoom ranges from 0 (totally determined by SceneButtonList) to 1
  // (fullscreen).
  SmoothFloat zoom;
  
  
  SceneButton(String name, Scene scene) {
    this.name = name;
    this.scene = scene;
    
    float initial = 0;
    float duration = 0.8;
    this.zoom = new SmoothFloat(initial, duration);
  }
  
  // This will allow the buttons to be sorted by zoom, which allows us to
  // render the "active" scene (the one being zoomed in on) in front of the
  // rest.
  int compareTo(SceneButton button) {
    if (this.zoom.value < button.zoom.value) return -1;
    if (this.zoom.value > button.zoom.value) return 1;
    return 0;
  }
  
  // This returns zoom.value after cubic easing
  float easedZoom() {
    return easeInOutCubic(zoom.value);
  }
  
  private float easeInOutCubic(float t) {
    // Stolen from: https://gist.github.com/gre/1650294
    return t<.5 ? 4*t*t*t : (t-1)*(2*t-2)*(2*t-2)+1;
  }
}
}
