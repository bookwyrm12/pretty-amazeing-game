class CharacterPlayer extends Character {
  String name;
  float score;
  
  CharacterPlayer() {
    super();
  }
  
  CharacterPlayer(String name, String icon) {
    super(icon);
    this.name = name;
  }
  
  void changeName(String name) {
    this.name = name;
  }
  
  void randomName() {
    
  }
}
