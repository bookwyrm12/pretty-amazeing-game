/**** VARIABLES ****/
App app;
SceneMainMenu mm;
SceneLevel level;
SceneOptions options;
CharacterPlayer player;

/**** VARIABLES WITH VALUES ****/
int wCells = 24;
int hCells = 18;
float cellSize = 25;

/**** DO THINGS ****/
void setup() {
  size(800, 600);
  app = new App();
  player = new CharacterPlayer();
  mm = new SceneMainMenu(app);
  options = new SceneOptions(app);
  level = new SceneLevel(app, wCells, hCells);
}

void draw() {
  app.preTick();
  mm.tick();
  mm.draw();
  app.postTick();
}
