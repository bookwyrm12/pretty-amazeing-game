/*App app;
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
}*/

Maze maze;

void setup() {
  size(800, 600);
  maze = new Maze(20, 20);
  MazeGenerator gen = new MazeGenerator();
  gen.generate(maze);
}

void draw() {
  maze.draw();
}

void keyPressed() {
  if (key == 'r') {
    MazeGenerator gen = new MazeGenerator();
    gen.generate(maze);
  }
}
