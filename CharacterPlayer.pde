class CharacterPlayer extends Character {
  int id;
  String name;
  float score; // not implemented/future idea
  IntList completedLevels;
  
  CharacterPlayer() {
    super();
    this.id = generateID();
    this.completedLevels = new IntList();
    
    SaveData saveData = new SaveData();
    saveData.loadFile();
    saveData.loadPlayerData(this);
  }
  
  CharacterPlayer(String name, String icon) {
    super(icon);
    this.id = generateID();
    this.name = name;
    this.completedLevels = new IntList();
    
    SaveData saveData = new SaveData();
    saveData.loadFile();
    saveData.loadPlayerData(this);
  }
  
  void load(int id) {
    // not implemented/future idea
  }
  
  int generateID() {
    SaveData save = new SaveData();
    return save.getNextID();
  }
  
  void changeName(String name) {
    this.name = name;
  }
  
  String randomName() {
    // Yes, this is a great list of names to choose from.
    // In the future, it would be cool to implement some NLP for this.
    String[] randNames = { "April", "Joy", "Jamie" };
    int randPicker = int(random(randNames.length));
    return randNames[randPicker];
  }
  
  void changeIcon(String newIcon) {
    super.changeIcon(newIcon);
  }
  
  void updateScore() {
    // not implemented/future idea
  }
  
  void completeLevel(int level) {
    // If the level is not already in completed list, add it
    if (!this.completedLevels.hasValue(level)) {
      this.completedLevels.append(level);
      SaveData save = new SaveData();
      save.updatePlayerData(this);
    }
  }
  
  boolean hasCompletedLevel(int level) {
    return this.completedLevels.hasValue(level);
  }
}
