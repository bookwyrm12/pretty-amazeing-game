class SceneLevelSelect extends Scene {
  SceneMainMenu mainMenu;
  
  SceneLevelSelect(SceneMainMenu mainMenu) {
    super(mainMenu.app);
    this.mainMenu = mainMenu;
  }
  
  void draw() {
    // Draw a white background
    fill(0);
    noStroke();
    rect(bounds.x, bounds.y, bounds.w, bounds.h);
    
    // Draw the pattern
    float h = (1 - zoom) * 25;
    float w = h + zoom * bounds.w * 3 / 4;
    //float t = zoom * 0.75 + 0.25;
    pushMatrix();
    translate(bounds.getCenter().x, bounds.getCenter().y);
    stroke(255);
    pattern(w, h);
    popMatrix();
  }
  
  void pattern(float w, float h) {
    line(-w/2+1, 0, 0,  h/2);
    line( w/2, 0, 0,  h/2);
    line(-w/2+1, 0, 0, -h/2);
    line( w/2, 0, 0, -h/2);
  }
}
