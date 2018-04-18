import java.util.ArrayDeque;
import java.util.Iterator;
import processing.sound.*;

App app;
SceneMainMenu mm;
CharacterPlayer player;
SceneOptions options;
Music music;
ColorPallete CP;

void setup() {
  size(800, 600);
  app = new App();
  player = new CharacterPlayer();
  mm = new SceneMainMenu(app);
  music = new Music();
  //music.play_music();
  CP = new ColorPallete();
}

void draw() {
  app.preTick();
  mm.tick();
  mm.draw();
  app.postTick();
}

void keyPressed() {
  app.onKeyPress(key, keyCode);
}

/*Maze maze;
CharacterPlayer player;

void setup() {
  size(800, 600);
  player = new CharacterPlayer();
  maze = new Maze(20, 20, new Vec2(20, 20));
  MazeGenerator gen = new MazeGenerator();
  gen.generate(maze);
  player.setCoords(maze, maze.startX, maze.startY);
}

void draw() {
  background(200);
  maze.draw(player);
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
