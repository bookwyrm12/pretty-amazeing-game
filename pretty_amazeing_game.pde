App app;
SceneMainMenu mm;
SceneLevel level;

void setup() {
  size(800, 600);
  app = new App();
  mm = new SceneMainMenu(app);
  level = new SceneLevel(app, 24, 18);
}

void draw() {
  app.preTick();
  mm.tick();
  mm.draw();
  app.postTick();
}
