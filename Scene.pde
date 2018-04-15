class Scene {
  App app;
  Rect bounds; // The bounds in which the scene is rendered
  
  Scene(App app) {
    this.app = app;
    this.bounds = new Rect(0, 0, width, height);
  }
  
  void tick() {
  }
  
  void draw() {
  }
}
