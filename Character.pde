class Character {
  PShape icon;
  int posx, posy; // coordinates in the maze grid
  
  Character() {
    this.icon = loadShape("char_ladybug.svg"); // default icon
  }
  
  Character(String icon) {
    this.icon = loadShape("char_" + icon + ".svg");
  }
  
  void draw() {
    pushMatrix();
    move();
    // TODO
    popMatrix();
  }
  
  void move() {
    // TODO
  }
  
  void changeIcon(String newIcon) {
    PShape tmp = loadShape("char_" + newIcon + ".svg");
    if (tmp != null) {
      this.icon = tmp;
    }
  }
}
