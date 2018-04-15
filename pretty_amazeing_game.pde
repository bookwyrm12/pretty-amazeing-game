/**** VARIABLES ****/
App app;
SceneMainMenu mm;
SceneLevel level;
SceneOptions options;
CharacterPlayer player;

/**** DO THINGS ****/
void setup() {
  size(800, 600);
  app = new App();
  player = new CharacterPlayer();
  mm = new SceneMainMenu(app);
  options = new SceneOptions(app);
  level = new SceneLevel(app, 1);
}

void draw() {
  app.preTick();
  mm.tick();
  mm.draw();
  app.postTick();
}
