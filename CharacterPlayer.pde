class CharacterPlayer extends Character {
  int id;
  String name;
  float score;
  
  CharacterPlayer() {
    super();
    this.id = generateID();
  }
  
  CharacterPlayer(String name, String icon) {
    super(icon);
    this.id = generateID();
    this.name = name;
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
  
  void updateScore() {
    // TODO
  }
}
