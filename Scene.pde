class Scene {
  App app;
  Rect bounds; // The bounds in which the scene is rendered
  float zoom; // Value from [0, 1] indicating the transition from one scene to another
  
  Scene(App app) {
    this.app = app;
    this.bounds = new Rect(0, 0, width, height);
  }
  
  void tick() {
  }
  
  void draw() {
  }
}
