import processing.sound.*;

App app;
SceneMainMenu mm;
Music music;

void setup() {
  size(800, 600);
  app = new App();
  mm = new SceneMainMenu(app);
  music = new Music();
  music.play_music();
}

void draw() {
  app.preTick();
  mm.tick();
  mm.draw();
  app.postTick();
}

/*Maze maze;

void setup() {
  size(800, 600);
  maze = new Maze(20, 20);
  MazeGenerator gen = new MazeGenerator();
  gen.generate(maze);
}

void draw() {
  background(200);
  maze.draw();
  fill(0);
  textSize(12);
  textAlign(LEFT, TOP);
  text(maze.seed, 0, 0);
}

void keyPressed() {
  if (key == 'r') {
    MazeGenerator gen = new MazeGenerator();
    gen.generate(maze);
  }
}*/
