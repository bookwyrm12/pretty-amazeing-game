class Character {
  PShape icon;
  
  Character() {
    this.icon = loadShape("char_ladybug.svg"); // default icon
  }
  
  Character(String icon) {
    this.icon = loadShape("char_" + icon + ".svg");
  }
  
  void draw() {
    
  }
  
  void move() {
    
  }
  
  void changeIcon(String newIcon) {
    PShape tmp = loadShape("char_" + newIcon + ".svg");
    if (tmp != null) {
      this.icon = tmp;
    }
  }
}
