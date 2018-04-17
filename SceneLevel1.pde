class SceneLevel1 extends SceneLevel {
  //SceneLevelSelect levelSelect;
  
  SceneLevel1(SceneLevelSelect levelSelect) {
    super(levelSelect, 1);
    gen.generate(maze, 1178750592);
  }
  
  //void tick() {
  //  boolean controlsActive = (bounds.w > 500);
    
  //  if (controlsActive && app.wasMouseClicked()) {
  //    this.levelSelect.goToLevelSelect();
  //  }
  //}
  
  //void draw(CharacterPlayer player) {
  //  fill(255);
  //  noStroke();
  //  rect(bounds.x, bounds.y, bounds.w, bounds.h);
  //  fill(0);
  //  textAlign(CENTER, CENTER);
  //  textSize(bounds.h / 5);
  //  text("Level 1", bounds.getCenter().x, bounds.getCenter().y);
  //  maze.draw(player);
  //}
}
