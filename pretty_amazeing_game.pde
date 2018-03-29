App app;
SceneMainMenu mm;

void setup() {
  size(800, 600);
  app = new App();
  mm = new SceneMainMenu(app);
}

void draw() {
  app.preTick();
  mm.tick();
  mm.draw();
  app.postTick();
}
