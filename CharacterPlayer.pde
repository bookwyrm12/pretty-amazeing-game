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
    }
  }
}
