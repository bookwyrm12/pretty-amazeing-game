class CharacterPlayer extends Character {
  int id;
  String name;
  float score; // not implemented/future idea
  IntList completedLevels;
  
  CharacterPlayer() {
    super();
    this.id = generateID();
    this.completedLevels = new IntList();
  }
  
  CharacterPlayer(String name, String icon) {
    super(icon);
    this.id = generateID();
    this.name = name;
    this.completedLevels = new IntList();
  }
  
  int generateID() {
    // TODO
    return 0;
  }
  
  void changeName(String name) {
    this.name = name;
  }
  
  void randomName() {
    // TODO
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
    }
  }
}
