class SceneLevel1 extends Scene {
  SceneLevelSelect levelSelect;
  
  SceneLevel1(SceneLevelSelect levelSelect) {
    super(levelSelect.app);
    this.levelSelect = levelSelect;
  }
}
