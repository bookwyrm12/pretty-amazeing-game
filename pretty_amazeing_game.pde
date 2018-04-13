App app;
SceneMainMenu mm;
SceneLevel level;
SceneOptions options;
CharacterPlayer player;

void setup() {
  size(800, 600);
  app = new App();
  player = new CharacterPlayer();
  mm = new SceneMainMenu(app);
  options = new SceneOptions(app);
  level = new SceneLevel(app, 24, 18);
}

void draw() {
  app.preTick();
  mm.tick();
  mm.draw();
  app.postTick();
}
