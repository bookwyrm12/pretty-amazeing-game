class SceneLevelSelect extends Scene {
  SceneMainMenu mainMenu;
  SceneButtonList sceneButtons; // Class(es) found below
  
  SceneLevelSelect(SceneMainMenu mainMenu) {
    super(mainMenu.app);
    this.mainMenu = mainMenu;
    this.sceneButtons = new SceneButtonList(this.bounds);
    this.sceneButtons.addButton("level 1", new SceneLevel1(this));
    this.sceneButtons.addButton("level 2", new SceneLevel2(this));
    this.sceneButtons.addButton("level 3", new SceneLevel3(this));
  }
  
  void tick() {
    // We will enable button controls only when we are entirely in the main menu
    boolean controlsActive = (this.zoom > 0.9); // Feels nicer than zoom == 1
    for (SceneButton button : sceneButtons.buttons) {
      if (button.zoom.isStable() && button.zoom.value == 0) {
        continue;
      }
      controlsActive = false;
    }
    
    // Check for button clicks
    if (controlsActive) {
      
      boolean clickedButton = false;
      for (SceneButton button : sceneButtons.buttons) {
        Vec2    mousePos          = app.getMousePos();
        boolean mouseClicked      = app.wasMouseClicked();
        boolean mouseWithinBounds = button.scene.bounds.contains(mousePos);
        
        // If clicked, zoom in on that scene
        if (mouseClicked && mouseWithinBounds) {
          button.zoom.animateTo(1);
          clickedButton = true;
        }
      }
      
      if (!clickedButton) {
        this.mainMenu.goToMainMenu();
      }
    }
    
    // Update the zoom & bounds for the scenes
    for (SceneButton button : sceneButtons.buttons) {
      button.zoom.tick(app.deltaTime);
      button.scene.zoom = easeInOutCubic(button.zoom.value);
      button.scene.bounds = button.minRect.lerp(this.bounds, button.scene.zoom);
    }
    
    // Update the logic for the scenes
    for (SceneButton button : sceneButtons.buttons) {
      button.scene.tick();
    }
  }
  
  void draw() {
    // Draw a black background
    fill(0);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    
    { // Draw options label
      Vec2 pos1 = bounds.getCenter();
      Vec2 pos2 = bounds.getCenter().sub(new Vec2(0, bounds.h / 4));
      Vec2 pos = pos1.lerp(pos2, this.zoom);
      
      float size1 = 10;
      float size2 = 24;
      float size = lerp(size1, size2, this.zoom);
      
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(size);
      text("Play", pos.x, pos.y);
    }
    
    // Draw the scenes
    sceneButtons.sortByZoom();
    sceneButtons.repositionButtons(this.zoom);
    for (SceneButton button : sceneButtons.buttons) {
      button.scene.draw();
    }
  }
  
  void goToLevelSelect() {
    // Zoom out of all scenes
    for (SceneButton button : sceneButtons.buttons) {
      if (button.zoom.value != 0) {
        button.zoom.animateTo(0);
      }
    }
  }
  
  private float easeInOutCubic(float t) {
    // Stolen from: https://gist.github.com/gre/1650294
    return t<.5 ? 4*t*t*t : (t-1)*(2*t-2)*(2*t-2)+1;
  }
  
  
  
  class SceneButton {
    String      name;
    Scene       scene;
    Rect        minRect;
    SmoothFloat zoom;
    
    SceneButton() {
      float initial = 0;
      float duration = 0.8;
      zoom = new SmoothFloat(initial, duration);
    }
    
    int compareTo(SceneButton button) {
      if (this.zoom.value < button.zoom.value) return -1;
      if (this.zoom.value > button.zoom.value) return 1;
      return 0;
    }
  }
  
  class SceneButtonList {
    Rect bounds;
    ArrayList<SceneButton> buttons;
    
    SceneButtonList(Rect bounds) {
      this.bounds = bounds;
      this.buttons = new ArrayList<SceneButton>();
    }
    
    void addButton(String name, Scene scene) {
      SceneButton button = new SceneButton();
      button.name = name;
      button.scene = scene;
      button.minRect = new Rect(0, 0, 100, 50);
      buttons.add(button);
    }
    
    void sortByZoom() {
      // Stolen from: https://trinisoftinc.wordpress.com/2012/03/29/simple-sorting-algorithms-implementations-part-1/
      for (int i = 1; i < buttons.size(); ++i) {
        SceneButton b1 = buttons.get(i);
        int j = i - 1;
        while (j >= 0 && buttons.get(j).compareTo(b1) > 0) {
          buttons.set(j + 1, buttons.get(j));
          --j;
        }
        buttons.set(j + 1, b1);
      }
    }
    
    SceneButton findButtonByName(String name) {
      for (SceneButton button : buttons) {
        if (button.name.equals(name)) {
          return button;
        }
      }
      return null;
    }
    
    void repositionButtons(float scale) {
      float sumHeight = 0;
      for (SceneButton button : buttons) {
        sumHeight += button.minRect.h;
      }
      
      float verticalSpacing = 40;
      float totalHeight = sumHeight + verticalSpacing * (buttons.size() - 1);
      
      float accumY = bounds.getCenter().y - totalHeight / 2;
      for (SceneButton button : buttons) {
        Rect r = button.minRect;
        r.x = bounds.getCenter().x - r.w / 2;
        r.y = accumY;
        accumY += r.h + verticalSpacing;
      }
    }
  }
}
